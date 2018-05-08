from django.db import models
from django.utils import timezone

class Blog(models.Model):
    title = models.CharField(max_length=200, unique=True)
    short_title = models.CharField(max_length=100, unique=True)
    slug = models.SlugField(max_length=100, unique=True)
    introduction = models.TextField(default='no introduction')
    body = models.TextField()
    posted = models.DateTimeField(db_index=True, auto_now_add=True)
    # edited = models.DateTimeField(db_index=True, auto_now_add=True) # needs to be adjusted 

# my version:
# class comments(models.Models):
#     
#     body = models.TextField()
#     posted = models.DateTimeField(db_index=True, auto_now_add=True)
#     edited = models.DateTimeField(db_index=True, auto_now_add=True) # needs to be adjusted
#     # edited? think that is stored somewhere anyway?
#     # but maybe there will be changes anyway that are
#     # not related to the edit

# django girls' version:
class Comment(models.Model):
    """ TODO:
            - should know what cascade does..

    """
    post = models.ForeignKey('Blog', 
            related_name='comments', 
            on_delete=models.CASCADE,)
    author = models.CharField(max_length=200)
    text = models.TextField()
    created_date = models.DateTimeField(default=timezone.now)
    approved_comment = models.BooleanField(default=True)

    def approve(self):
        self.approved_comment = True
        self.save()

    def __str__(self):
        return self.text
  
   
    
     
      
       

