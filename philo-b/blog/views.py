from django.views import View
from django.views.generic.list import ListView
from django.shortcuts import get_object_or_404, render, redirect
from django.contrib import auth
from django.conf import settings
from django.http import JsonResponse, HttpResponse 
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_http_methods

from blog.forms import CommentForm 
from blog.models import Blog, Comment


class Overview(ListView):

	model = Blog
	template_name = 'blog/home.html'

	def render_to_response(self, context, **response_kwargs):
		user = auth.get_user(self.request)

		if user.is_authenticated:
			context['user'] = user
		
		context['object_list'] = context['object_list'].order_by('-posted')
		
		return super().render_to_response(context, **response_kwargs)


class Post(View):

	template_name = 'blog/post.html'
	comment_form = CommentForm

	def get(self, request, *args, **kwargs):
		post = get_object_or_404(Blog, id=self.kwargs['post_id'])
		user =  auth.get_user(request)

		context = {}
		context['post'] = post
		context['comments'] = post.comment_set.all().order_by('path')

		if user.is_authenticated:
			context['comment_form'] = self.comment_form
			context['user'] = user

		return render(request, self.template_name, context)


@login_required
@require_http_methods(["POST"])
def add_comment(request, post_id):
	form = CommentForm(request.POST)
	post = get_object_or_404(Blog, id=post_id)

	if form.is_valid():
		comment = Comment()
		comment.path = []
		comment.post_id = post
		comment.author_id = auth.get_user(request)
		comment.content = form.cleaned_data['text_area']

		# - you need to save to generate the id
		comment.save()

		# - if comment is not a subcomment (reply)
		#	then parent_id=None
		parent_id = form.cleaned_data['parent_comment_id']

		# - accounts for when other clients have replied
		#	in the mean time
		if (parent_id != None):
			comment_prev = Comment.objects.get(id=parent_id)
			cluster = comment_prev.cluster

			# - cluster of the new comment isn't set yet, so
			#	this creates the correct result
			comment_last = Comment.objects.filter(cluster=cluster).order_by('path').last()
			comment_last.is_last = False
			comment_last.save()
			comment.path.extend(comment_last.path)
		else:
			cluster = Comment.objects.all().order_by('cluster').last().cluster + 1
			comment.is_first = True

		comment.path.append(comment.id)
		comment.cluster = cluster
		comment.save()

		comments_db_count = Comment.objects.filter(post_id=post_id).count()
		comments_client_count = int(request.POST['comments_amount_prev']) + 1

		if (comments_db_count != comments_client_count):
			return JsonResponse({ 'success': True, 'reload': True })

		return JsonResponse(prepare_process_info(comment, parent_id))

	try:
		parent_id = form.cleaned_data['parent_comment_id']
	except KeyError:
		return HttpResponse(status=500)

	return JsonResponse(prepare_errors_info(form, parent_id))


def prepare_process_info(comment, parent_id):
	comment_data = { 'id': comment.id,
					 'author_id': comment.author_id.username,
					 'content': comment.content,
					 'pub_date': comment.pub_date.strftime(settings.DATETIME_FORMAT_LP),
					 'is_first': comment.is_first,
					 'is_last': comment.is_last,
					 # 'path': comment.path,
					}

	process_info = { 'success': True,
					 'reload': False,
					 'parent_id': convert_p_id(parent_id),
				     'comment_object': comment_data,
					}

	return process_info


def prepare_errors_info(form, parent_id):
	messages = []
	for key, value in form.errors.items():
		messages.extend(value)

	error_info = { 'success': False,
				   'parent_id': convert_p_id(parent_id), 
				   'messages': messages,
				  }

	return error_info


def convert_p_id(parent_id):

	if (parent_id == None):
		return 'default'

	return parent_id

