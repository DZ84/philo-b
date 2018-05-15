from django.views import View
from django.views.generic.list import ListView
from django.shortcuts import render_to_response, get_object_or_404, redirect
from django.contrib import auth
from django.http import Http404
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_http_methods
from django.core.exceptions import ObjectDoesNotExist
from django.template.context_processors import csrf
 
from blog.forms import Comment_Form 
from blog.models import Blog, Comment
# from config.settings.base import AUTH_USER_MODEL as auth_user 

class Overview(ListView):
    
    model = Blog
    template_name = 'blog/home.html'

class Post(View):

    template_name = 'blog/post.html'
    comment_form = Comment_Form 
     
    def get(self, request, *args, **kwargs):
        post = get_object_or_404(Blog, id=self.kwargs['post_id'])
        context = {}
        context.update(csrf(request))
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

        return render_to_response(template_name=self.template_name, context=context)

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
 
        determine_first()
        determine_last()

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

        determine_first()
        determine_last()

        comment.save()
    return redirect(post.get_absolute_url())

def determine_first():
    ordered_comments = Comment.objects.all().order_by('path')
     
    for index, comment in enumerate(ordered_comments[1:], 1):
        spot = index-1
        if (len(comment.path) <= len(ordered_comments[spot].path)): 
            comment.is_first = True
            continue 
        
        comment.is_first = False
    ordered_comments[0].is_first = True

def determine_last():
    ordered_comments = Comment.objects.all().order_by('path')
    
    for index, comment in enumerate(ordered_comments[1:], 1):
        spot = index-1
        if (len(comment.path) > len(ordered_comments[spot].path)): 
            ordered_comments[index-1].is_last = False
            continue 

        ordered_comments[index-1].is_last = True
    ordered_comments[spot+1].is_last = True

# def determine_last():
# 
#     ordered_comments = Comment.objects.all().order_by('path')
#     
#     for index, comment in enumerate(ordered_comments[-2:1]):
#         if (len(comment.path) <= len(ordered_comments[index-1].path)): 
# 
#             ordered_comments[index-1].is_last = True 
#             continue 
# 
#         ordered_comments[index-1].is_last = False
#     ordered_comments[-1].is_last = True

