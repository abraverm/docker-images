FROM fedora
MAINTAINER Alexander Braverman "abraverm@redhat.com"

# Setting variables
ENV FOREMAN 1.7-stable
ENV WITHOUT 'mysql2 pg test'
ENV RAILS_ENV production

# Installing dependencies
# Puppet, libraries and tools
RUN rpm -ivh http://yum.puppetlabs.com/fedora/f21/products/x86_64/puppetlabs-release-21-11.noarch.rpm
RUN yum install -y -q tar sudo git puppet gcc-c++ patch \
    libvirt-devel openssl-devel libxml2-devel sqlite-devel \
    libxslt-devel zlib-devel readline-devel \
    postgresql-devel mysql-devel  readline readline-devel zlib \
    libyaml-devel libffi-devel make bzip2 autoconf automake libtool bison iconv-devel

# RVM - for running with 1.9.3
RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -L get.rvm.io | bash -s stable
ENV PATH $PATH:/usr/local/rvm/bin/
RUN rvm requirements && rvm install 1.9.3
RUN rvm 1.9.3 rubygems current
RUN rvm 1.9.3 do gem install rails mysql2

# Downloading source
WORKDIR /opt
RUN git clone https://github.com/theforeman/foreman.git -b $FOREMAN --depth 1
WORKDIR /opt/foreman

# Initialiazing foreman
RUN cp config/settings.yaml.example config/settings.yaml && cp config/database.yml.example config/database.yml
RUN rvm 1.9.3 do ruby --version
RUN rvm 1.9.3 do gem install bundler
RUN rvm 1.9.3 do bundle install --without $WITHOUT --path vendor
RUN rvm 1.9.3 do bundle exec rake db:migrate
RUN rvm 1.9.3 do bundle exec rake db:seed assets:precompile locale:pack
RUN rvm 1.9.3 do bundle exec rake permissions:reset password=changeme

# Finalize
ADD ./start.sh /opt/start.sh
RUN touch /init
EXPOSE 3000
CMD /opt/start.sh
