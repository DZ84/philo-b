from django.db import models
from django.conf import settings
from django.utils import timezone
from django.urls import reverse

from django.contrib.postgres.fields import ArrayField
from ckeditor.fields import RichTextField
from ckeditor_uploader.fields import RichTextUploadingField


class Blog(models.Model):

    short_title = models.CharField(max_length=100, unique=True)
    slug = models.SlugField(max_length=100, unique=True)
    title = models.CharField(max_length=200, unique=True)
    summary = models.TextField(blank=True, null=True)
    content = RichTextUploadingField(null=True)
    posted = models.DateTimeField(db_index=True, auto_now_add=True)

    def get_absolute_url(self):
        return reverse('post', kwargs={ 'slug': self.slug, 'post_id': self.id })


class Comment(models.Model):

    class Meta:
        db_table = "comments"

    path = ArrayField(models.IntegerField())
    post_id = models.ForeignKey(Blog, on_delete=models.PROTECT)
    author_id = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT)
    content = models.TextField('Comment', default='"This is my default message."')
    pub_date = models.DateTimeField('Date of comment', default=timezone.now)
    is_first = models.BooleanField(default=False)
    is_last = models.BooleanField(default=True)

    def __str__(self):
        return self.content[0:200]

