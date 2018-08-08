# Description:
#   Send attend E-mail using slack.
#
# Commands:
#   @hubot 勤怠 下痢がひどいので10:00〜出社します
#

# mail module
nodemailer = require "nodemailer"
xoauth2 = require "xoauth2"
yaml = require "node-yaml"

loadSettingYaml = (configYamlPath) ->
  yaml.readSync configYamlPath,
    encoding: "utf8"
    schema: yaml.schema.defaultSafe, (err, setting) ->
      try
        console.log setting
        return setting
      catch error
        throw error

loadUserYaml = (configYamlPath) ->
  yaml.readSync configYamlPath,
    encoding: "utf8"
    schema: yaml.schema.defaultSafe, (err, userList) ->
      try
        console.log userList
        return userList
      catch error
        throw error

getMailServerConf = ->
  setting = loadSettingYaml "config/settings.yaml"
  return setting["mailServer"]

getSendTo = ->
  setting = loadSettingYaml "config/settings.yaml"
  return setting["sendto"]

getUserInfo = (username) ->
  userInfo = loadUserYaml "config/user.yaml"
  return userInfo[username]

createMailerTransport = ->
  mailServerConf = getMailServerConf()

  transport = nodemailer.createTransport
    host: mailServerConf["host"]
    port: mailServerConf["port"]
    secure: mailServerConf["secure"]
    auth:
      user: mailServerConf["user"]
      pass: mailServerConf["pass"]

  return transport

sendMail = (from, name, text)->
  sendTo = getSendTo()
  transport = createMailerTransport()
  mailData =
    from   : "#{name} <#{from}>"
    to     : "<#{sendTo}>"
    subject: "勤怠連絡 #{name}"
    text   : "#{text}"
  console.log mailData

  try
    transport.sendMail mailData
  catch error
    throw error
  finally
    transport.close

module.exports = (robot) ->
  robot.respond /勤怠(.*)/i, (msg) ->
    username = msg.message.user.name
    userInfo = getUserInfo username
    fullName = userInfo["fullName"]
    mail = userInfo["mail"]
    text = msg.match[1]

    try
      sendMail(mail, fullName, text)
      msg.send "下記内容で勤怠連絡したよ！\nSubject: 勤怠管理 #{fullName}\nText: #{text}"

    catch error
      msg.send("送信失敗... 今日は休めないや..どんまい")
      msg.send("エラーメッセージ\n #{error}")



