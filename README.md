Foreman
=======
The Foreman image was designed for working 'out of the box'. The start script
handles initialization.Foreman needs signed keys for connecting to a
smart-proxy. It uses the keys which puppet generates. The keys which are used
by Foreman and smart-proxy should be signed by the same CA server.
Following options are available for setting the CA server.

> Note : The container can be started without CA server as argument or shared
> volume. However without smart-proxy Foreman's functionality is limited.

Options
-------
1. Setting CA server

    Part of container initialization is to create certificates which is done
by puppet. There is an option in puppet to choose who is the CA server.
You can pass the CA server on creation of the container :

        docker run -d -P -h foreman abraverm/foreman ca.server.com 8140


2. Sharing configurations with host

  Following configuration can be accessable by the host:

   - /opt/foreman/config/
   - /etc/puppet/puppet.conf
  > The initial script will link those configurations into directory /shared.

  To create the directory and share it with host , use **--volume** argument
  when creating the container:

        docker run -d -v /path/in/host:/shared -P -h foreman abraverm/foreman

  Setting the CA server is done by editing puppet.conf
  (/path/in/host/puppet.conf).

  Create a file named **ssl** in /path/in/host/:

        touch /path/to/host/ssl

  Restart the container (the start script will generate new certificates):

TO-DO
-----

  - Automate version and tagging - remove hard coded version in Dockerfile
  - Build matrix (mysql,postgress, internal)
  - Fig - entire infrastructure
  - Better configuration management

[1]: http://docs.puppetlabs.com/puppet/latest/reference/environments.html#enabling-directory-environments
