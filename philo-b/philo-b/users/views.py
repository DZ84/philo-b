from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse
from django.views.generic import DetailView, ListView, RedirectView, UpdateView

from .models import CustomUser


class UserDetailView(LoginRequiredMixin, DetailView):
    model = CustomUser
    # These next two lines tell the view to index lookups by username
    slug_field = "username"
    slug_url_kwarg = "username"


class UserRedirectView(LoginRequiredMixin, RedirectView):
    permanent = False
    def get_redirect_url(self):
        return reverse("users:detail", kwargs={"username": self.request.user.username})


class UserUpdateView(LoginRequiredMixin, UpdateView):

    fields = ["username"]

    # we already imported User in the view code above, remember?
    model = CustomUser

    def get_object(self):
        # Only get the User record for the user making the request
        return CustomUser.objects.get(username=self.request.user.username)


class UserListView(LoginRequiredMixin, ListView):
    model = CustomUser
    # These next two lines tell the view to index lookups by username
    slug_field = "username"
    slug_url_kwarg = "username"

# class ConfirmEmailView ....... extend......?

