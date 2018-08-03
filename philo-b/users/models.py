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

    def delete(self, *args, **kwargs):
        
        print("Opened this delete function")

        if self.deleted == False:
            self.deleted = True
            self.save()
            print("changed and saved")
            return True
        elif self.deleted == True:
            print("nothing changed") 
            return True

        # this may need to be saved
        print("something went wrong")
        
        return False


from django.db.models.signals import pre_delete 
from django.dispatch import receiver

@receiver(pre_delete, sender=User)
def delete_user(sender, instance, **kwargs):

    print("received a signal")
    
    print("called before: " + str(instance.deleted))

    if instance.delete():
        return

    print("called after: " + str(instance.deleted))

    raise NotImplementedError() 

