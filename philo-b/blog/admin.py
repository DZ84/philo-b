from django.contrib import admin
from django.conf import settings

from .models import Blog, Comment


# class CustomAdmin(admin.ModelAdmin):
# 	pass

# admin.site.unregister(Blog)
# admin.site.unregister(Comment)
admin.site.register(Blog)
admin.site.register(Comment)
