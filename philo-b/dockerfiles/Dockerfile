# from here: https://rehalcon.blogspot.mx/2018/03/dockerize-your-django-app-for-local.html	
# apparently some of these commands will be overwritten by docker-compose
#
# NOTE: start from main django app folder

FROM python:3.5.2-slim
ENV PYTHONUNBUFFERED 1

# so here you copy and install the requirementsfile first before adding
# the whole app folder to prevent invalidating the build cache everytime 
# you add the whole application. I think this works in layers..?

RUN mkdir /philo-b-docker

# I suspect it would be better to set all the installs mentioned in these
# requirement files, and mention them seperately in these dockerfiles.

# Weird: you can't go relatively up, you'll go outside the "building context",
# and these paths are from the folder you start the build for image from.
# Thus you'll need to start from main app folder.
COPY ./requirements/base.txt /philo-b-docker/requirements/base.txt
COPY ./requirements/local.txt /philo-b-docker/requirements/local.txt
WORKDIR /philo-b-docker

# is this something you want? isn't the whole idea of the docker
# that you keep the env steady?
# so maybe not the upgrade, but yes to the update
# RUN apt-get update && apt-get upgrade -y && apt-get install -y gcc
# and I need this for the gcc, which has to do with pip?
RUN apt-get update && apt-get install -y gcc

# this is for debugging. Is also present in production dockerfile. Should
# probably be removed in actual production.
RUN apt-get install -y vim net-tools 

RUN pip install --upgrade pip==10.0.1

RUN pip install -r /philo-b-docker/requirements/base.txt
RUN pip install -r /philo-b-docker/requirements/local.txt

# TODO: fix typo
# this does not seem to be necessary, because the folder is created
# but without type is also created.
# this one does not connect to the db, so may not even be used
ADD . /philo-b-docker/



# I believe you can turn comment this one out also
# EXPOSE 8004



# ENV DB_NAME philob 
# ENV USERNAME mysuperuser 
# ENV HOSTNAME localhost 
# ENV PORT 5432 
# ENV TOKEN_FOR_MY_APP ............ #dont think I'm using this...?

# CMD ["manage.py", "runserver", "0.0.0.0:8000"]


#        'ENGINE': 'django.db.backends.postgresql_psycopg2',
#        'NAME': 'philob',
#        'USER': 'mysuperuser',  # this is not a django superuser, but a db user, if I'm not mistaken ofcourse.
#        'PASSWORD': 'strong and secure', # needs to be changed after deployment
#        'HOST': 'localhost',
#        'PORT': '5432',
#    }

# RUN useradd -ms /bin/bash vault
# 
# RUN echo 'newuser:newpassword' | chpasswd
# adduser vault sudo
# 
# USER vault
# WORKDIR /usr/local/bin/vault
# 
# RUN ln -sf /bin/bash /bin/sh
# RUN useradd -ms /bin/bash  vault




# actually, I dont really know what this does.
RUN useradd -d /home/ubuntu -ms /bin/bash -g root -G sudo -p ubuntu ubuntu
USER ubuntu
WORKDIR /home/ubuntu
