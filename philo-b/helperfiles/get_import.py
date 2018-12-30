# this can be helpfull for debugging
# when trying to import files from 
# 'philo-b' folder. This can be 
# problematic because the name
# includes a dash.

um = __import__('philo-b')
u = um.users.models.User
ua = u.objects
