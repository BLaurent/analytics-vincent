FROM jupyter/datascience-notebook:latest

RUN conda install --quiet --yes -c conda-forge fbprophet pandas scikit-learn tensorflow keras plotnine && \
    conda remove --quiet --yes --force qt pyqt && \
    conda clean -tipsy

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y clean
RUN apt-get -y update
RUN apt-get install -y -qq wget curl apt-transport-https
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EEA14886 && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-get update -qq -y && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  apt-get install -y -qq oracle-java8-installer maven

RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add -
RUN echo "deb http://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get -y -qq update && apt-get -y -qq install cf-cli git nano vim

RUN apt-get -y -qq clean && \
  rm -rf /var/lib/apt/lists/*

USER jovyan
