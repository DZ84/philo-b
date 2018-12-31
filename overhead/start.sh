#!/bin/bash

function manage_app () {
	python philo-b-docker/manage.py makemigrations
	python philo-b-docker/manage.py migrate
}

function start_development() {
	# use django runserver as development server here.
	# manage_app
	python3 /philo-b-docker/manage.py runserver 0.0.0.0:8004
	# python /philo-b-docker/manage.py runserver 127.0.0.1:8004
	# python /philo-b-docker/manage.py runserver 
}

function start_production() {
	# use gunicorn for production server here
	# manage_app
	# gunicorn bookme.wsgi -w 4 -b 0.0.0.0:8000 --chdir=/app --log-file -
	
	# gunicorn /philo-b-docker/philo-b.wsgi -w 4 -b 0.0.0.0:8004 --log-file -

	
	# what was preload for again?

	# move to the right folder for the command:
	cd /philo-b-docker
	# the exec is quite nice, it prevents an extra, or the wrong, gunicorn to
	# be executed. This changes the shutting down process, enabling it to be
	# gracefully stopped. Before, it took longer, which was the default max time
	# before it was forcefully stopped.

	# exec gunicorn config.wsgi -w 4 -b 0.0.0.0:8004 --log-file=- 
	# --reload --preload 


	# gunicorn config.wsgi -w 4 -b 'unix:///tmp/gunicorn1.sock' --log-file=- 
	# gunicorn config.wsgi -w 4 -b 'unix:///overhead/gunicorn/gunicorn.sock' --log-file=- 
	# --reload --preload 

	python manage.py runserver 0.0.0.0:8004
}

if [ ${PRODUCTION} == "false" ]; then
	# use development server
	start_development
else
	# use production server
	start_production
fi

