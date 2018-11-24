from django.db import models
from django.conf import settings
from django.utils import timezone
# from django.contrib.auth.models import User
# from config import settings
from django.urls import reverse

from django.contrib.postgres.fields import ArrayField


class Blog(models.Model):
    title = models.CharField(max_length=200, unique=True)
    short_title = models.CharField(max_length=100, unique=True)
    slug = models.SlugField(max_length=100, unique=True)
    introduction = models.TextField(default='no introduction')
    body = models.TextField()
    posted = models.DateTimeField(db_index=True, auto_now_add=True)

    def get_absolute_url(self):
        return reverse('post', kwargs={ 'slug': self.slug, 'post_id': self.id })

class Comment(models.Model):

    class Meta:
        db_table = "comments"

    path = ArrayField(models.IntegerField())
    post_id = models.ForeignKey(Blog, on_delete=models.CASCADE)
    author_id = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    content = models.TextField('Comment', default='"This is my default message."') # I want to have quotes here.
    pub_date = models.DateTimeField('Date of comment', default=timezone.now)
    is_first = models.BooleanField(default=False)
    is_last = models.BooleanField(default=True)

    def __str__(self):
        return self.content[0:200]
 
