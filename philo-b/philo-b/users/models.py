from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.db import models
from django.urls import reverse
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _


class SoftDeletionQuerySet(models.query.QuerySet):
    def delete(self):
        return super(SoftDeletionQuerySet, self).update(deleted_at=timezone.now())

    def hard_delete(self):
        return super(SoftDeletionQuerySet, self).delete()

    def alive(self):
        return self.filter(deleted_at=None)

    def dead(self):
        return self.exclude(deleted_at=None)


class SoftDeletionManager(BaseUserManager):
    def __init__(self, *args, **kwargs):
        self.alive_only = kwargs.pop('alive_only', True)
        super(SoftDeletionManager, self).__init__(*args, **kwargs)

    def get_queryset(self):
        if self.alive_only:
            return SoftDeletionQuerySet(self.model).filter(deleted_at=None)
        return SoftDeletionQuerySet(self.model)

    def hard_delete(self):
        return self.get_queryset().hard_delete()


class SoftDeletionModel(models.Model):
    deleted_at = models.DateTimeField(blank=True, null=True)

    objects = SoftDeletionManager()
    all_objects = SoftDeletionManager(alive_only=False)

    class Meta:
        abstract = True

    def delete(self):
        self.deleted_at = timezone.now()
        self.email = "deleted_" + self.email + "!@/"
        self.is_active = False
        self.save()

    def hard_delete(self):
        super(SoftDeletionModel, self).delete()


class User(SoftDeletionModel, AbstractUser):

    # First Name and Last Name do not cover name patterns
    # around the globe.
    name = models.CharField(_("Name of User"), blank=True, max_length=255)
    deleted = models.BooleanField(default=False)

    def __str__(self):
        return self.username

    def get_absolute_url(self):
        return reverse("users:detail", kwargs={"username": self.username})
        #return reverse(name='post', kwargs={
        #                                'slug': 'ssd', 
        #                                'id': 1
        #                            })



#     def delete(self, *args, **kwargs):
#         
#         print("Opened this delete function")
# 
#         if self.deleted == False:
#             self.deleted = True
#             self.save()
#             print("changed and saved")
#             return True
#         elif self.deleted == True:
#             print("nothing changed") 
#             return True
# 
#         # this may need to be saved
#         print("something went wrong")
#         
#         return False


# from django.db.models.signals import pre_delete 
# from django.dispatch import receiver
# 
# @receiver(pre_delete, sender=User)
# def delete_user(sender, instance, **kwargs):
# 
#     print("received a signal")
#     
#     print("called before: " + str(instance.deleted))
# 
#     if instance.delete():
#         print("called after: " + str(instance.deleted))
#         return
# 
# 
#     raise NotImplementedError() 

