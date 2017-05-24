FROM fedora
# install firefox
RUN dnf install -y firefox
# install dependancies
RUN dnf install -y libcanberra-gtk3 PackageKit-gtk3-module \
    dbus dbus-devel dbus-x11
RUN dbus-uuidgen --ensure

# make uid and gid match inside and outside the container
# replace 1000 with your gid/uid, find them by running
# the id command
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/firefox && \
    echo "firefox:x:${uid}:${gid}:Developer,,,:/home/firefox:/bin/bash" >> /etc/passwd  && \
    echo "firefox:x:${uid}:" >> /etc/group  && \
    echo "firefox ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  && \
    chmod 0440 /etc/sudoers  && \
    chown ${uid}:${gid} -R /home/firefox
# Improve Fonts
RUN dnf install -y -q abattis-cantarell-fonts

# ERB for vimperator
RUN dnf install -y -q ruby

# Adobe Flash
ADD adobe-linux-x86_64.repo /etc/yum.repos.d/
RUN dnf install -y -q flash-plugin

# Spice
RUN dnf install -y -q virt-viewer spice-xpi

# Pass
RUN dnf install -y -q pass which gnupg pinentry-gtk

#remove cache from the image to shrink it a bit
RUN dnf clean all

# set up and run firefox
USER firefox
ENV HOME /home/firefox
CMD /usr/bin/firefox
