from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
# from config.settings.base import AUTH_USER_MODEL as auth_user 

from django.urls import reverse

from django.contrib.postgres.fields import ArrayField

class Blog(models.Model):
    title = models.CharField(max_length=200, unique=True)
    short_title = models.CharField(max_length=100, unique=True)
    slug = models.SlugField(max_length=100, unique=True)
    introduction = models.TextField(default='no introduction')
    body = models.TextField()
    posted = models.DateTimeField(db_index=True, auto_now_add=True)
    # edited = models.DateTimeField(db_index=True, auto_now_add=True) # needs to be adjusted 
    # posted can be different from created

    def get_absolute_url(self):
        return reverse('post', kwargs={'slug': self.slug})

# my version:
# class comments(models.Models):
#     
#     body = models.TextField()
#     posted = models.DateTimeField(db_index=True, auto_now_add=True)
#     edited = models.DateTimeField(db_index=True, auto_now_add=True) # needs to be adjusted
#     # edited? think that is stored somewhere anyway?
#     # but maybe there will be changes anyway that are
#     # not related to the edit

# # django girls' version:
# class Comment(models.Model):
#     """ TODO:
#             - should know what cascade does..
# 
#     """
#     post = models.ForeignKey('Blog', 
#             related_name='comments', 
#             on_delete=models.CASCADE,)
#     author = models.CharField(max_length=200)
#     text = models.TextField()
#     created_date = models.DateTimeField(default=timezone.now)
#     approved_comment = models.BooleanField(default=True)
# 
#     def approve(self):
#         self.approved_comment = True
#         self.save()
# 
#     def __str__(self):
#         return self.text
  
   
class Comment(models.Model):
    
    class Meta:
        db_table = "comments"
         
    path = ArrayField(models.IntegerField(), default=[])
    blog_id = models.ForeignKey(Blog, on_delete=models.CASCADE, default=1)
    # author_id = models.ForeignKey(auth_user, on_delete=models.CASCADE, default=1)
    author_id = models.ForeignKey(User, on_delete=models.CASCADE, default=1)
    content = models.TextField('Comment', default="oooooooooooooooooooooooook")
    pub_date = models.DateTimeField('Date of comment', default=timezone.now)

    def __str__(self):
        return self.content[0:200]

#     def get_offset(self):
#         level = len(self.path) - 1
#         if level > 5:
#             level = 5
#             return level
# 
#     def get_col(self)
#         level = len(self.path) - 1
#         if level > 5:
#             level = 5
#         return 12 - level

