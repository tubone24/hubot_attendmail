# Hubot Slack to attend mail plugin

![header](./docs/header.png)

Send attend mails using Slack you only talk to Hubot.

## Dependency

* Docker

## Setup

* Setting SMTP server config (src/config/settings.yaml)

```yaml
mailServer:
  host: SMTP server host or IP address
  port: SMTP server port
# if usr TLS, "secure" attribute "true"
  secure: true
  user: SMTP username
  pass: SMTP password

sendto: Mail address you send to attend
```

* Setting user mapping config (src/config/user.yaml)

```yaml
slack-user: # Slack username(@mention name)
  fullName: Full name (put mail subject)
  mail: User mail address
```

* Get HUBOT_SLACK_TOKEN to Slack Admin console and set ENV value for Dockerfile

```
ENV HUBOT_SLACK_TOKEN xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

* Build docker image

```
$ docker build -f dockerfile/Dockerfile -t hubot:latest .
```

* Run docker container

```
$ docker run -it --name hubot hubot:latest
```

* Or run docker container on background

```
$ docker run -d --name hubot hubot:latest
```

## Usage

* Run container.

* Talk to (@mention) hubot attend reaso,  start from "勤怠"

* Send attend mail. Have a nice holiday!

![send_attend](https://raw.githubusercontent.com/tubone24/hubot_attendmail/master/docs/send_attend.png "send attend")

# Licence
This software is released under the MIT License, see LICENSE.

# Authors
tubone

