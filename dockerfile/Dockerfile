FROM node
MAINTAINER tubone

RUN npm install -g yo generator-hubot
RUN npm list -g yo generator-hubot
RUN npm install xoauth2
RUN npm install nodemailer
RUN npm install node-yaml
RUN useradd bot
RUN mkdir /home/bot && chown bot.bot /home/bot

USER bot
WORKDIR /home/bot
RUN  yo hubot --owner "tubone" --name "bot" --description "Hubot image" --adapter slack

COPY src/ scripts/

ENV HUBOT_SLACK_TOKEN xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CMD bin/hubot --adapter slack
