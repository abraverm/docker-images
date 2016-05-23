FROM fedora:22
MAINTAINER Alexander Braverman
WORKDIR /opt
RUN dnf -y install \
  http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
RUN dnf install -y git gcc ffmpeg-devel gnutls-devel json-c-devel \
  libgcrypt-devel make libao-devel faad2-devel libmad-devel libao faad2-libs \
  libcurl-devel pulseaudio
RUN git clone https://github.com/PromyLOPh/pianobar.git
RUN cd pianobar && make && make install
RUN mkdir -p /root/.config/pianobar && \
  cp /opt/pianobar/contrib/config-example /root/.config/pianobar/config

# PulseAudio
RUN echo enable-shm=no >> /etc/pulse/client.conf
ENV PULSE_SERVER /run/pulse/native

COPY start.sh /start.sh
ENTRYPOINT ["/start.sh"]

CMD ["pianobar"]
