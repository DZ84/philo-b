from django.views import View
from django.views.generic.list import ListView
from django.shortcuts import get_object_or_404, redirect, render #, render_to_response
from django.contrib import auth
from django.conf import settings
from django.http import Http404, JsonResponse, HttpResponse 
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_http_methods
from django.core.exceptions import ObjectDoesNotExist
from django.core import serializers
	
from blog.forms import CommentForm 
from blog.models import Blog, Comment


class Overview(ListView):

	model = Blog
	template_name = 'blog/home.html'

	def render_to_response(self, context, **response_kwargs):
		user = auth.get_user(self.request)

		if user.is_authenticated:
			context['user'] = user

		return super().render_to_response(context, **response_kwargs)


class Post(View):

	template_name = 'blog/post.html'
	comment_form = CommentForm 

	def get(self, request, *args, **kwargs):
		context = {}

		post = get_object_or_404(Blog, id=self.kwargs['post_id'])
		user =  auth.get_user(request)

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

		# from relevant site:
		# Django does not allow to see the comments on the ID, we do not save it,
		# Although PostgreSQL has the tools in its arsenal, but it is not going to
		# work with raw SQL queries, so form the path after the first save
		# And resave a comment
		comment.save()

		# get id of comment to which is replied. If comment is
		# not a subcomment (reply) then parent_id=None
		parent_id = form.cleaned_data['parent_comment_id']

		# if parent comment is present its path is needed and
		# its status as last comment in the thread needs to be
		# set to false.
		if (parent_id != None):

			# you could try and except this, but it is already
			# covered by checking for None.
			comment_prev = Comment.objects.get(id=parent_id)
			comment_prev.is_last = False
			comment_prev.save() 
			comment.path.extend(comment_prev.path) 
		else:
			comment.is_first = True	

		# attach the own id to finish the
		# path of the new comment
		comment.path.append(comment.id)
		comment.save()

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

