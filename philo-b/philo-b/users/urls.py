from django.conf.urls import url
from django.urls import path

from . import views

app_name = "users"
urlpatterns = [
    url(regex=r"^$", view=views.UserListView.as_view(), name="list"),
    url(regex=r"^~redirect/$", view=views.UserRedirectView.as_view(), name="redirect"),
    url(
        regex=r"^(?P<username>[\w.@+-]+)/$",
        view=views.UserDetailView.as_view(),
        name="detail",
    ),
    # url(
    #     regex=r"^(?P<username>[\w.@+-]+)/$",
    #     view=views.UserUpdateView.as_view(),
    #     name="update",
    # ),
    path(
        'email_confirmed',
        views.UserUpdateView.as_view(),
        name="update"
    ),
]

