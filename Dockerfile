FROM centos
MAINTAINER Inigo Arredondo <inigo.arredondo@ehu.eus>

#User arguments in case you want another epics version, user or working dir.
ARG EPICS_VER
ENV EPICS_VER ${EPICS_VER:-3.16.1}
ARG WORK_DIR
ENV WORK_DIR ${WORK_DIR:-/usr/local/epics}
ARG USER
ENV USER ${USER:-epics}
# The user is needed when compiling an ioc (if the env vble is not set
# makeBaseApp.pl thinks that you are in Windows)

#Install necessary packages
RUN yum install -y \
         vim \
         wget \
         gcc-c++ \
         readline-devel \
         perl-devel \
         make

#Download epics base uncompress and move to the working dir
RUN wget https://www.aps.anl.gov/epics/download/base/base-$EPICS_VER.tar.gz
RUN tar -zxvf base-$EPICS_VER.tar.gz
RUN mkdir $WORK_DIR
RUN mv base-$EPICS_VER $WORK_DIR
#Remove the source
RUN rm base-$EPICS_VER.tar.gz

#Optionally create a symbolic link to base
RUN cd $WORK_DIR && ln -s base-$EPICS_VER base

#Do the necessary exports
RUN echo "export EPICS_HOST_ARCH=linux-x86_64" >> ~/.bashrc
RUN echo "export EPICS_BASE="$WORK_DIR"/base" >> ~/.bashrc
RUN echo "export PATH=$PATH:"$WORK_DIR"/base/bin/linux-x86_64" >> ~/.bashrc

RUN source ~/.bashrc && cd $WORK_DIR/base && make

#Make the EPICS port available
EXPOSE 5065 5064
