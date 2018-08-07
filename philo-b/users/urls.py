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
        # 'bladibla/',  # NOTE: how is a forward slah here giving an error..?
        # 'email_confirmed/redirect/update', 
        views.UserUpdateView.as_view(), 
        name="update"
    ),
]

# trailing slash in path gives the following error

# Page not found (404)
# Request Method: GET
# Request URL:    http://0.0.0.0:8004/users/email_confirmed/
# Raised by:  *app-name*.users.views.UserDetailView
# 
# No user found matching the query
