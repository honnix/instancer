# Introducing

This tiny sinatra backed web app is used as instance register, the typical
usage scenarios is described in following section.

# Typical Usage Scenarios

## DB Instance Startup

1. start DB normally

2. register IP address of itself to *instancer*

   `curl -d "ip=xxx.xxx.xxx.xxx" http://host:port/db`

## App Instance Startup

1. before starting app

2. contact *instancer* to get IP address of DB instance

   `curl http://host:port/db`

3. normally, there would be only one DB instance, and the returned value is pure IP
   address string

4. configure local DB connection string

5. continue with normal app startup

6. register IP address of itself to *instancer**

   `curl -d "ip=xxx.xxx.xxx.xxx" http://host:port/app`

## App Instance Shutdown

1. shutdown app normally

2. unregister IP address of itself from *instancer*

   `curl -X DELETE -d "ip=xxx.xxx.xxx.xxx" http://host:port/app`

## Load Balancer Startup

1. before starint load balancer

2. contact *instancer* to get IP addresses of all app instances

3. there would be pure IP addresses string returned in format of
   "xxx.xxx.xxx.xxx,yyy.yyy.yyy.yyy"

4. configure and start

# How to Use

## Install All Dependencies

`gem install bundle`

> This will install bundle gem.

`bundle install`

> This will install all dependencies

## Go Start

`rackup -s thin`
