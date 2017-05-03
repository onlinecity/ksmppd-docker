# ksmppd dockerized

A sample project on how to dockerize ksmppd, including a kannel docker-compose stack. It's based on alpine linux to keep the containers lightweight.

### Installation & usage

To use this you can clone the repo and configure it as required.

This repo is set up for testing purposes and creates a loop between ksmppd and bearerbox using example configs from ksmppd. You probably want to change that.

It uses a mysql database for ksmppd auth and routing. This database is preloaded with sample data from the initdb directory. You'll want to change this, either use http instead of mariadb or see the [mariadb docker howto](https://hub.docker.com/_/mariadb/).

In the config folder you'll find the sample configs for ksmppd and the kannel loop.

To test this it run `docker compose up` , if you see failures run it again since on first run mysql needs to set up additional things.

After everything is running you can inject a message into the loop by using the provided sms box.

`curl "http://localhost:14013/cgi-bin/sendsms?username=tester&password=foobar&message=Test"`

You can also check out the ksmppd status page

`curl "http://localhost:14010/esme-status?password=ksmppdpass"`

### Caveats

This project is provided in the hope it might be useful to someone, and is not supported or endorsed by OnlineCity in any way.

The sample config in this project is unsafe, remember to change passwords etc. Use at own risk.