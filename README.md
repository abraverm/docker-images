Foreman container
=================
This Dockerfile allows running Foreman git version in container.
It requires passing arguments during build:

  - FOREMAN - git branch\verion\tag\commit to checkout and install foreman from.
  - RUBY_VER - using RVM to run Foreman from specific Ruby version.
  - WITHOUT - Excluding gems during Foreman installation from source, for more details read [Foreman Install From Source][1]

Example
-------
0. If additional plugins needed, declare them in "plugins"
directory. For example:
create 'plugins/foreman_reserve.rb' with the following content:

    gem 'foreman_reserve'

Docker will add the plugins before Foreman installation to bundler.d folder (/opt/foreman/bundler.d).

1. Build:

    docker build --build-arg FOREMAN="1.7-stable" --build-arg RUBY_VER="2.0.0" --build-arg WITHOUT="mysql2 pg test" -t abraverm/foreman:1.7 .

2. Run:

    docker run -d -P -e RUBY_VER="2.0.0" abraverm/foreman:1.7

3. Foreman should be available at the assigned port (i.e 49157),
browse to:

    http://localhost:49157

4. Enter Foreman with the following credentials:
  - User name:

      admin

  - Password:

      changeme

<Reference Links>
[1]: http://theforeman.org/manuals/1.7/#3.4InstallFromSource
