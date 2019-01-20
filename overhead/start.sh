#!/bin/bash

function manage_app () {
	python philo-b-docker/manage.py makemigrations
	python philo-b-docker/manage.py migrate
}

function start_development() {
	# use django runserver as development server here.
	python /philo-b-docker/manage.py runserver 0.0.0.0:8004
}

function start_production() {
	# move to the right folder for the command:
	cd /philo-b-docker

	# PRODUCTION, mode
	# exec gunicorn config.wsgi -w 4 -b 0.0.0.0:8004 --log-file=- 

	# the exec prevents an extra, or the wrong, gunicorn to
	# be executed. You notice this when shutting down the container; it won't
	# shut down gracefully.


	# DEBUG mode, for explanations read below
	exec gunicorn config.wsgi -w 4 -b 0.0.0.0:8004 --log-file=- -t 90000 --max-requests 1 

	# for pdb: when workers are silent for a certain period, they restart. -t specifies
	# the length of this period. Enabling you to use pdb in the meantime. 90000 seconds
	# should be enough.
	# -t 90000

	# not meant for production, reload is suppose to reload workers when code changes
	# --reload --preload 
	# but I prefer the max-requests option, it gives (much?) more insurance that the new load
	# runs on the new code, although with adjustments in settings, 2 reloads might be necessary.
	# --max-requests 1
}

if [ ${PRODUCTION} == "false" ]; then
	# use development server
	start_development
else
	# use production server
	start_production
fi

