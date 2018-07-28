from django.contrib.auth.models import AbstractUser
from django.db import models
from django.urls import reverse
from django.utils.translation import ugettext_lazy as _


class User(AbstractUser):

    # First Name and Last Name do not cover name patterns
    # around the globe.
    name = models.CharField(_("Name of User"), blank=True, max_length=255)
    deleted = models.BooleanField(default=False)

    def __str__(self):
        return self.username

    def get_absolute_url(self):
        return reverse("users:detail", kwargs={"username": self.username})

    def delete(self):

        if self.deleted == False:
            self.deleted = True
            return True
        elif self.deleted == True:
            return True

        return False



from django.db.models.signals import pre_delete 
from django.dispatch import receiver

@receiver(pre_delete, sender=User)
def delete_user(sender, instance, **kwargs):
    
    if instance.delete():
        return

    raise NotImplementedError() 

