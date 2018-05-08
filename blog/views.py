from django.shortcuts import render
from django.views.generic.list import ListView
from django.views.generic import DetailView

from blog.models import Blog


class Overview(ListView):
    
    model = Blog
    template_name = 'blog/home.html'


class Post(DetailView):
    
    model = Blog
    template_name = 'blog/post.html'

