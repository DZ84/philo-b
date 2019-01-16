from django.contrib import admin
from django.conf import settings

from .models import Blog, Comment, Image


admin.site.register(Blog)
admin.site.register(Comment)
admin.site.register(Image)

