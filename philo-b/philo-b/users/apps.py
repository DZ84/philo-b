from django.apps import AppConfig


class UsersConfig(AppConfig):
    name = "philo-b.users"
    verbose_name = "CustomUsersApp"

    def ready(self):
        """Override this to put in:
            Users system checks
            Users signal registration
        """
        try:
            import users.signals  # noqa F401
        except ImportError:
            pass
