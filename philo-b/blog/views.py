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
		# comment.conten = form.cleaned_data['text_area'] # how did this never created a problem?
		comment.content = form.cleaned_data['text_area']

		# from relevant site:
		# Django does not allow to see the comments on the ID, we do not save it,
		# Although PostgreSQL has the tools in its arsenal, but it is not going to
		# work with raw SQL queries, so form the path after the first save
		# And resave a comment
		comment.save()

		# get id of comment to which is replied. If comment is
		# not a subcomment (reply) then parent_id=None
		parent_id = form.cleaned_data['parent_comment_id']
		comment_prev = Comment.objects.get(id=parent_id)

		import pdb
		pdb.set_trace()

		# get previous comment, but in the mean time there
		# may have been replies from other clients.
		cluster = comment_prev.cluster
		comment_last = Comment.objects.filter(cluster=cluster).order_by('path').last()

		if (parent_id != None):
			comment.path.extend(comment_last.path)

			comment_last.last = False
			comment_last.save()
		else:
			comment.is_first = True

		# attach the own id to finish the
		# path of the new comment
		comment.path.append(comment.id)
		comment.cluster = cluster
		comment.save()

		# check length If length != length before+1 renew completely
			# unless you do some session stuff, this might make you
			# lose things you've typed in other boxes, which is fine
			# ofcourse.
				# so it's not perfect, but it prevends you from not
				# being up to date.

		comments_db_count = Comment.objects.filter(post_id=post_id).count()
		comments_client_count = int(request.POST['comments_amount_prev']) + 1

		print(comments_db_count)
		print(comments_client_count)

		print('adjusted code1')

		if (comments_db_count != comments_client_count):
			print('got here')
			return JsonResponse({ 'success': True, 'reload': True })

		print('did get here')

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

