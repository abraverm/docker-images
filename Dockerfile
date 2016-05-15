FROM fedora
RUN curl -o /etc/yum.repos.d/beaker-client-Fedora.repo https://beaker-project.org/yum/beaker-client-Fedora.repo
RUN yum install -y git wget python-unittest2 python-nose python-futures \
    python-paramiko python-lxml python-six python-configobj python-pip \
    python-argparse python-glanceclient python-keystoneclient python-novaclient \
    gcc compat-gcc-34.x86_64 libffi-devel python-devel openssl-devel \
    libxml2-devel libxslt-devel graphviz lftp krb5-workstation cloud-utils \
    python-neutronclient libxslt-python beaker-client
RUN pip install --upgrade pip
RUN pip install taskrunner
RUN pip install python-foreman
RUN pip install ansible==1.8.4
CMD /bin/bash
