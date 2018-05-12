from django.db import models
from django.utils import timezone
#from django.contrib.auth.models import User
from config import settings
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
        return reverse('post', kwargs={ 'slug': self.slug, 'post_id': self.id })

class Comment(models.Model):
    
    class Meta:
        db_table = "comments"
         
    path = ArrayField(models.IntegerField())
    post_id = models.ForeignKey(Blog, on_delete=models.CASCADE)
    author_id = models.ForeignKey(settings.base.AUTH_USER_MODEL, on_delete=models.CASCADE)
    # author_id = models.ForeignKey(User, on_delete=models.CASCADE, default=1)
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

