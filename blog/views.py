from django.views import View
from django.views.generic.list import ListView
from django.shortcuts import get_object_or_404, redirect, render #, render_to_response
from django.contrib import auth
from django.http import Http404
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_http_methods
from django.core.exceptions import ObjectDoesNotExist
# from django.template.context_processors import csrf
 
from blog.forms import Comment_Form 
from blog.models import Blog, Comment

class Overview(ListView):
    
    model = Blog
    template_name = 'blog/home.html'

class Post(View):

    template_name = 'blog/post.html'
    comment_form = Comment_Form 

    def get(self, request, *args, **kwargs):
        post = get_object_or_404(Blog, id=self.kwargs['post_id'])
        context = {}



        # import os
        # print("printing HOME:" + str(os.environ.get('HOME')))
        # print("printing DJANGO_SECRET_KEY:" + str(os.environ.get('DJANGO_SECRET_KEY')))
        # print("printing DJANGO_DEBUG:" + str(os.environ.get('DJANGO_DEBUG')))


        # for csrf: template.context_processors.csrf or template.RequestContext?

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
            context['form'] = self.comment_form
            context['user'] = user # is this a safe move? think so, if django allows it so easily

        # return render_to_response(template_name=self.template_name, context=context)
        return render(request, self.template_name, context)

@login_required
@require_http_methods(["POST"])
def add_comment(request, post_id):

    form = Comment_Form(request.POST)
    post = get_object_or_404(Blog, id=post_id)
 
    if form.is_valid():
        comment = Comment()
        comment.path = []
        comment.post_id = post 
        # comment.author_id = auth_user # auth.get_user(request)
        comment.author_id = auth.get_user(request)
        comment.content = form.cleaned_data['comment_area']
 
        comment.save()

        # Django does not allow to see the comments on the ID, we do not save it,
        # Although PostgreSQL has the tools in its arsenal, but it is not going to
        # work with raw SQL queries, so form the path after the first save
        # And resave a comment
        try:
            comment.path.extend(Comment.objects.get(id=form.cleaned_data['parent_comment']).path)
            comment.path.append(comment.id)
        except ObjectDoesNotExist:
            comment.path.append(comment.id)

        comment.save()

        comment.det_set_first()
        determine_last(post)

    return redirect(post.get_absolute_url())

def update_first_of_all():
    # just for updating all after changing the code
    for comment in Comment.objects.all():
        comment.det_set_first()
    return

def determine_last(post_object):
    
    ordered_comments = post_object.comment_set.all().order_by('path')

    # ordered_comments = Comment.objects.all().order_by('path')
    
    for index, comment in enumerate(ordered_comments[1:], 1):
        spot = index-1
        if (len(comment.path) > len(ordered_comments[spot].path)): 
            ordered_comments[index-1].set_last(False)
            continue 

        ordered_comments[index-1].set_last(True)
    ordered_comments[spot+1].set_last(True)

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

