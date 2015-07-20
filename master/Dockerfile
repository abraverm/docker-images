FROM fedora
MAINTAINER Alexander Braverman "abraverm@redhat.com"
RUN yum install -y rubygems hostname
RUN gem install tiller
RUN rpm -ivh http://yum.puppetlabs.com/fedora/f21/products/x86_64/puppetlabs-release-21-11.noarch.rpm
RUN yum install -y puppet-server && yum clean all
ADD tiller /etc/tiller
CMD ["/usr/local/bin/tiller" , "-v"]

EXPOSE 8140
