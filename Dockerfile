FROM fedora
MAINTAINER Alexander Braverman "abraverm@redhat.com"
# Base
RUN yum install -y -q sudo java-1.8.0-openjdk java-1.8.0-openjdk-devel
# Improve Fonts
RUN yum install -y -q abattis-cantarell-fonts && yum clean all
# Source control
RUN yum install -y git && yum clean all
# Eclipse
RUN yum install -y -q eclipse
# Finalize
ADD start.sh /opt/
CMD /opt/start.sh
