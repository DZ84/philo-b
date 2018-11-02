from django.db import models
from django.utils import timezone
#from django.contrib.auth.models import User
# from config import settings
from django.urls import reverse

from django.contrib.postgres.fields import ArrayField

from django.conf import settings

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
    # plan: 
    #   - post_id also shouldn't stay cascade. If you delete the post, the
    #   comments may still be interesting
    #       - so do what here?
    #           - same trick as author_id
    #   - author_id is easier: you can add author name and preserve that 
    #   on_delete (with set?) and author_id can then be set to default on_delete
    
    # -! these solutions all seem very nice, but what if a name gets changed, will
    # it be changed in the comment model also? seems so, if it listens for delete,
    # why not for change?
    # -ok, but that means the info in the other models is also set her, double,
    # that means it uses too much, correct?

    # question:
    #   - does it has to be a number?

    #   - can foreignkey be null?
    #   
    #   overwrite delete function for users, and set it so it will not be detected?

    path = ArrayField(models.IntegerField())
    # NOTE: this is how I understand the CASCADE option now:
    # -do_nothing is not good, because new ones can be created, meaning a wrong link
    # so that would give error
    # -it is probably just a task that models.CASCADE performs
    # -you can choose on_delete=is NULL or something like that, then that is
    # the behavior. 
    # -!! so basically, when either Blog or User is deleted, the CASCADE is called
    # and the whole instance of Comment is grabbed and deleted.
    post_id = models.ForeignKey(Blog, on_delete=models.CASCADE)
    # author_id = models.ForeignKey(settings.base.AUTH_USER_MODEL, on_delete=models.CASCADE)
    author_id = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    # author_id = models.ForeignKey(User, on_delete=models.CASCADE, default=1)
    content = models.TextField('Comment', default='"This is my default message."') # I want to have quotes here.
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

