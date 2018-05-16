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
    is_last = models.NullBooleanField()
    is_first = models.NullBooleanField()

    def __str__(self):
        return self.content[0:200]
 
    def det_set_first(self):
        
        #import pdb
        #pdb.set_trace()

        if (len(self.path)==1):
            self.is_first = True 
        else:
            self.is_first = False 

        self.save()
        return 
 
    def set_last(self, value):

        if (self.is_last == value):
            return

        self.is_last = value
        self.save()
        return 

