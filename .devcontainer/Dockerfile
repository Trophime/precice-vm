ARG from=nvidia/opengl:1.2-glvnd-devel-ubuntu22.04

FROM ${from}
LABEL maintainer Christophe Trophime <christophe.trophime@lncmi.cnrs.fr>

ARG USERNAME=feelpp
ARG VGLUSERS_ID=1002

USER root

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Setup demo environment variables
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt update \
    && apt-get -y install sudo lsb-release mesa-utils glew-utils git git-lfs openssh-client software-properties-common \
    && apt-get -y install build-essential git cmake cmake-curses-gui \
    && apt-get install -y python-is-python3 python3-pip ipython3 \
    && apt-get install -y nano vim-nox emacs-nox \
    && apt-get install -y wget curl \
    && apt-get -y upgrade

# Make ssh dir
# Create known_hosts
# Add bitbuckets key
RUN mkdir /root/.ssh/ \
    && touch /root/.ssh/known_hosts \
    && ssh-keyscan -T 60 github.com >> /root/.ssh/known_hosts

#set up user so that we do not run as root
# Changing the password does not work on certain debian and is not needed
# echo "feelpp:docker" | chpasswd && \
RUN echo "creating vglusers group: VGLUSERS_ID=${VGLUSERS_ID}" && \
    groupadd -g ${VGLUSERS_ID} vglusers && \
    useradd -m -s /bin/bash -G sudo,video,vglusers feelpp && \
    mkdir -p  /etc/sudoers.d/ && \
    echo "feelpp ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/feelpp


USER feelpp
# RUN cd /home/feelpp \
#     && git clone https://github.com/precice/vm.git precice-vm \
#     && cd precice-vm \
#     && chmod ugo+x provisioning/*.sh
     
# Install preCICE 
# RUN cd /home/feelpp/precice-vm \
#     && ./provisioning/install-precice.sh \
#     # Install solvers, adapters, and related tools \
#     && ./provisioning/install-config-visualizer.sh \
#     && ./provisioning/install-openfoam.sh \
#     && ./provisioning/install-dealii.sh

#     && ./provisioning/install-calculix.sh \ # FTBS error in cubrul.f, cubrit.f
#     && ./provisioning/install-fenics.sh \
#     && ./provisioning/install-nutils.sh \
#     && ./provisioning/install-su2.sh \
#     && ./provisioning/install-code_aster.sh \
#     && ./provisioning/install-dune.sh \
#     && ./provisioning/install-paraview.sh \
#     && ./provisioning/install-julia-bindings.sh \
#     && ./provisioning/install-aste.sh

# # Post-installation steps
# RUN provisioning/post-install.sh

# RUN cp provisioning/get-started.desktop ~/Desktop/get-started.desktop
# RUN cp provisioning/.alias ~/.alias

# # Pre-packaging steps
# RUN provisioning/cleanup.sh

WORKDIR /home/feelpp
CMD ["bash"]

