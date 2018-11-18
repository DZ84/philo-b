from django.views import View
from django.views.generic.list import ListView
from django.shortcuts import get_object_or_404, redirect, render #, render_to_response
from django.contrib import auth
from django.http import Http404
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_http_methods
from django.core.exceptions import ObjectDoesNotExist
# from django.template.context_processors import csrf

from blog.forms import CommentForm 
from blog.models import Blog, Comment

class Overview(ListView):

	model = Blog
	template_name = 'blog/home.html'

class Post(View):

	template_name = 'blog/post.html'

	# TODO: remove this weird in between step of renaming forms?
	# or does it create an easier adjustment if/when those are due?
	# - same for add comment
	comment_form = CommentForm 

	def get(self, request, *args, **kwargs):
		post = get_object_or_404(Blog, id=self.kwargs['post_id'])
		context = {}

		# context.update(csrf(request))
		# context['update'] = (csrf(request))
		# user = auth_user # auth.get_user(request)
		user =  auth.get_user(request)
		context['post'] = post

	# Put in the context of all the comments that are relevant to the blog 
	# simultaneously sorting them along the way, the auto-increment ID, 
	# so the problems with the hierarchy should not have any comments yet
		context['comments'] = post.comment_set.all().order_by('path') 
	# context['next'] = blog.get_absolute_url()

	# We add form only if the user is authenticated
		if user.is_authenticated:
			context['comment_form'] = self.comment_form
			context['user'] = user # is this a safe move? think so, if django allows it so easily

		# return render_to_response(template_name=self.template_name, context=context)
		return render(request, self.template_name, context)


from django.urls import reverse
from django.http import HttpResponseRedirect as hrr


from django.shortcuts import redirect

def testje(request):
	print('doing testje')
	# return reverse('about')
	# return hrr(reverse('about'))
	#return hrr(reverse('admin:index', current_app='blog'))
	# return reverse('admin:index', app_name='blog')
	# return hrr(reverse('admin:login', kwargs={}))
	# return hrr(reverse('adminerato:login', kwargs={}))
	# return hrr(reverse('admin:login'))
	return redirect('admin:login')



@login_required
@require_http_methods(["POST"])
def add_comment(request, post_id):

	form = CommentForm(request.POST)
	post = get_object_or_404(Blog, id=post_id)

	# TODO: what if form is not valid?
	if form.is_valid():
		comment = Comment()
		comment.path = []
		comment.post_id = post 
		# comment.author_id = auth_user # auth.get_user(request)
		comment.author_id = auth.get_user(request)
		# TODO: if a form is empty I expect this is where it goes wrong.
		comment.content = form.cleaned_data['text_area']

		comment.save()

		# Django does not allow to see the comments on the ID, we do not save it,
		# Although PostgreSQL has the tools in its arsenal, but it is not going to
		# work with raw SQL queries, so form the path after the first save
		# And resave a comment

		# print(form.cleaned_data['parent_comment'])

		# get id of comment to which is replied. If comment is
		# not a reply then parent_id=None
		parent_id = form.cleaned_data['parent_comment_id']

		# import pdb
		# pdb.set_trace()

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
			#	comment_prev = None
			comment.is_first = True	

		# attach the own id to finish the
		# path of the new comment
		comment.path.append(comment.id)
		comment.save()

		return redirect(post.get_absolute_url())

# # TODO: where is this called?
# def update_first_of_all():
# 	# just for updating all after changing the code
# 	for comment in Comment.objects.all():
# 		comment.det_set_first()
# 		return
# 
# def determine_last(post_object):
# 
# 	ordered_comments = post_object.comment_set.all().order_by('path')
# 
# 	# ordered_comments = Comment.objects.all().order_by('path')
# 
# 	for index, comment in enumerate(ordered_comments[1:], 1):
# 		spot = index-1
# 		if (len(comment.path) > len(ordered_comments[spot].path)): 
# 			ordered_comments[index-1].set_last(False)
# 			continue 
# 
# 		ordered_comments[index-1].set_last(True)
# 	ordered_comments[spot+1].set_last(True)

# def cleanup_stuff(self):
# 
#     var = Comment.objects.all().filter(path=[27, 63])
#     
#     post = get_object_or_404(Blog, id=self.kwargs['post_id'])
# 
#     postset = post.comment_set.all().order_by('path')
#  
#     for post in postset:
#         print("is_last: {}, path: {}".format(post.is_last, post.path))
# 
#     import pdb
#     pdb.set_trace()
#     
#     return

