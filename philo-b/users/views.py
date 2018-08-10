from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse
from django.views.generic import DetailView, ListView, RedirectView, UpdateView

from .models import User


class UserDetailView(LoginRequiredMixin, DetailView):
    model = User
    # These next two lines tell the view to index lookups by username
    slug_field = "username"
    slug_url_kwarg = "username"

    def dispatch(self, request, *args, **kwargs):
        print("we're at user DETAILview")
        return super(UserDetailView, self).dispatch(request, *args, **kwargs)

class UserRedirectView(LoginRequiredMixin, RedirectView):
    permanent = False
    def get_redirect_url(self):
        return reverse("users:detail", kwargs={"username": self.request.user.username})


class UserUpdateView(LoginRequiredMixin, UpdateView):

    fields = ["name"]

    # we already imported User in the view code above, remember?
    model = User

    def dispatch(self, request, *args, **kwargs):
        print("we're at user UPDATEview")
        return super(UserUpdateView, self).dispatch(request, *args, **kwargs)

    def get_object(self):
        # Only get the User record for the user making the request
        return User.objects.get(username=self.request.user.username)

class Redir(LoginRequiredMixin, RedirectView):
    def get_redirect_url(self):
        return reverse('users:update')

class UserListView(LoginRequiredMixin, ListView):
    model = User
    # These next two lines tell the view to index lookups by username
    slug_field = "username"
    slug_url_kwarg = "username"

# class ConfirmEmailView ....... extend......?

