FROM centos:8.2.2004
MAINTAINER Cineca (s.marocchi@cineca.it)

ENV DOCKERFILE_BASE=centos            \
    DOCKERFILE_DISTRO=centos          \
    DOCKERFILE_DISTRO_VERSION=8       \
    SPACK_ROOT=/opt/spack             \
    DEBIAN_FRONTEND=noninteractive    \
    CURRENTLY_BUILDING_DOCKER_IMAGE=1 \
    container=docker

RUN dnf repolist all
# dnf update -y \

RUN dnf install -y epel-release \
 && dnf install -y 'dnf-command(config-manager)' \
 && dnf config-manager --set-enabled PowerTools \
 && dnf --enablerepo epel groupinstall -y "Development Tools" \
 && dnf --enablerepo epel install -y \
        curl \
        findutils \
        gcc-c++ \
        gcc \
        gcc-gfortran \
        git \
        gnupg2 \
        hostname \
        iproute \
        Lmod \
        make \
        patch \
        tcl \
        unzip \
        which 

RUN dnf install -y python36

RUN python3 --version

RUN pip3.6 install boto3 \
 && rm -rf /var/cache/yum \
 && dnf clean all

RUN cd /opt && git clone https://github.com/spack/spack.git && cd spack && git checkout tags/v0.16.0

ENV MODULEPATH=/opt/spack/share/spack/modules/linux-centos8-skylake

RUN sed "/            unset CURRENTLY_BUILDING_DOCKER_IMAGE/i \            . \/usr\/share\/lmod\/8.2.7\/init\/bash" $SPACK_ROOT/share/spack/docker/entrypoint.bash > $SPACK_ROOT/share/spack/docker/entrypoint.bash.COPY && \
    mv $SPACK_ROOT/share/spack/docker/entrypoint.bash.COPY $SPACK_ROOT/share/spack/docker/entrypoint.bash

RUN chmod u+x $SPACK_ROOT/share/spack/docker/entrypoint.bash



RUN ln -s $SPACK_ROOT/share/spack/docker/entrypoint.bash \
          /usr/local/bin/docker-shell \
 && ln -s $SPACK_ROOT/share/spack/docker/entrypoint.bash \
          /usr/local/bin/interactive-shell \
 && ln -s $SPACK_ROOT/share/spack/docker/entrypoint.bash \
          /usr/local/bin/spack-env

RUN mkdir -p /root/.spack \
 && cp $SPACK_ROOT/share/spack/docker/modules.yaml \
        /root/.spack/modules.yaml \
 && rm -rf /root/*.* /run/nologin $SPACK_ROOT/.git

# [WORKAROUND]
# https://superuser.com/questions/1241548/
#     xubuntu-16-04-ttyname-failed-inappropriate-ioctl-for-device#1253889
RUN [ -f ~/.profile ]                                               \
 && sed -i 's/mesg n/( tty -s \\&\\& mesg n || true )/g' ~/.profile \
 || true

WORKDIR /root
SHELL ["docker-shell"]

# TODO: add a command to Spack that (re)creates the package cache
RUN spack spec hdf5+mpi

ENTRYPOINT ["/bin/bash", "/opt/spack/share/spack/docker/entrypoint.bash"]
CMD ["interactive-shell"]
