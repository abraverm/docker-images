#!/bin/bash
ca_server=$1
ca_port=$2
if [ -e "/init" ]; then
	puppet config set --section master ca false
	cat > /etc/puppet/manifests/site.pp << EOF
node default {
}
EOF
	if ! [ -z "$ca_server" ]; then
		puppet config set --section main ca_server "$ca_server"
	fi
	if ! [ -z "$ca_port" ]; then
		puppet config set --section main ca_port "$ca_port"
	fi
	puppet agent -t
	if [ -d "/shared" ]; then
		function share {
			mv "$1" "$2"
			ln -s "$2" "$1"
		}
		rm -rf /shared/*
		share /etc/puppet/puppet.conf /shared/puppet.conf
		share /opt/foreman/config /shared/config
	fi
	rm -rf /init
fi
if [ -e "/shared/ssl" ]; then
	rm -rf /var/lib/puppet/ssl
	puppet agent -t
	rm -rf /shared/ssl
fi
/usr/local/rvm/bin/rvm 1.9.3 do /opt/foreman/script/rails s -e production
exit 0
