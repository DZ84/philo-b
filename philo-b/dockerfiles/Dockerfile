# NOTE: start from main django app folder

FROM python:3.8.5-slim
ENV PYTHONUNBUFFERED 1

# so here you copy and install the requirementsfile first before adding
# the whole app folder to prevent invalidating the build cache everytime 
# you add the whole application.

RUN mkdir /philo-b-docker

COPY ./requirements/base.txt /philo-b-docker/requirements/base.txt
COPY ./requirements/local.txt /philo-b-docker/requirements/local.txt
WORKDIR /philo-b-docker

RUN apt-get update && apt-get install -y gcc

# this is for debugging. 
RUN apt-get install -y vim net-tools 

RUN pip install --upgrade pip==20.2.1
RUN pip install -r /philo-b-docker/requirements/base.txt
RUN pip install -r /philo-b-docker/requirements/local.txt

ADD . /philo-b-docker/

RUN useradd -d /home/ubuntu -ms /bin/bash -g root -G sudo -p ubuntu ubuntu
USER ubuntu
WORKDIR /home/ubuntu

