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
        'email_confirmed/',
        
        # 'bladibla/',  # NOTE: how is a forward slah here giving an error..?
        # 'email_confirmed/redirect/update', 

        #       - Path is very specific:
        #           - 'email_confirmed/okokok',
        #               - will not react to a give error if requested with a trailing / in the url.
        #               - but it will give a Page not found 404
        #                   - as opposed to the other one, which redirects when the trailing slash is there
        views.UserUpdateView.as_view(), 
        name="update"
    ),

    # if detail is off:
        # without /         - check
        # with /            - check

    # if detail is on:
        # without /         - check
        # with /            - error (!!!!!!)    - it redirects to UserDetailView. Which is weirs, it has no 
        #                                       reason to be there..
        #                                        
        #                                       path: the namespace is found, the path is stored, and
        #                                       then:
        #                                           - because it now has a url path that also matches
        #                                           it goes with that one?
        #                                               - this means that the matching is done
        #                                               after the namespaceing lookup?

        # Now you could say that it is foolish to set a url with a name that could also be matched
        # behind the matcher. But that doesn't matter. I refer to a namespace, it receives it, and looks it
        # up, and then decides to make a jump to some totally other urls pattern, unrelated. This is not
        # correct. 

        # hypothesis: this has nothing to do with the trailing slash, just whether it's a match.
    
    # if detail is on (without /):
        # without /         - error
        # with /            - check

        # hypothesis checks out. That does mean that this happens before reverse appends a trailing
        # slash on the url path. Or, because of the namespace afterwards.

        # and if details is behind in the row of patterns:
 
    # if detail is on (with /, behind in urlpattern):
        # without /         - check
        # with /            - check

    ##############################################################################################
    # CONCLUSION: it seems the namespace is converted into a URL, and then the URL is looked up. #
    ##############################################################################################
    
    # Could write a post about this.
    # could also ask for elaboration on stack exchange.

    url(
        'redir/go',
        views.Redir.as_view(),
        name='redir'
    ),
       # adding a trailing slash, and requesting it with one, also gives bad redirect
        # so which is the desired behavior?
        #   TODO: try is also with the other redirect shut down.

        # if detail is off:
            # redir/go, works with:
                # redir/go      - check 
                # redir/go/     - check
            # redir/go/, works with:
                # redir/go      - check
                # redir/go/     - check

        # if detail is on:
            # redir/go, works with:
                # redir/go      - check
                # redir/go/     - check
            # redir/go/, works with:
                # redir/go      - check
                # redir/go/     - check


        # if detail is off:
            # redir, works with:
                # redir         - check
                # redir/        - check
            # redir/, works with:
                # redir         - check
                # redir/        - check

        # if detail is on:
            # redir, works with:
                # redir         - error 
                # redir/        - error
            # redir/, works with:
                # redir         - error
                # redir/        - error

        ### OK: this all makes sense. And if you put it in
        # front of the detail url, then this would get priority




        # NOTE: expect: if no trailing slash in url, then it will
        # hardly ever work, because reverse(or django in general)
        # will automatically place a trailing / on any url that
        # does not have one.
        # BUT: when working with namespaces this shouldn't matter.

]

# trailing slash in path gives the following error

# Page not found (404)
# Request Method: GET
# Request URL:    http://0.0.0.0:8004/users/email_confirmed/
# Raised by:  *app-name*.users.views.UserDetailView
# 
# No user found matching the query

