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

transport = nodemailer.createTransport
  host: "smtp.host.example.com" # FIXME: Your SMTP Host
  port: 465
  secure: true
  auth:
    user: "smtp-username" # FIXME: Your SMTP username/password
    pass: "smtp-password"


loadUserList = (configYamlPath) ->
  yaml.read configYamlPath,
    encoding: "utf8"
    schema: yaml.schema.defaultSafe, (err, userList) ->
    try
      console.log data
    catch error
      throw error


sendMail = (mail, name, text)->
  mailData =
    from   : "#{name} <#{mail}>"
    to     : "<example@example.com>"
    subject: "勤怠連絡 #{name}"
    text   : "#{text}"
  console.log mailData

  try
    transport.sendMail mailData
  catch error
    throw error
  finally
    transport.close()



getUserFullName = (username) ->
  return userList[username].fullName

getUserMail = (username) ->
  return userList[username].mail


module.exports = (robot) ->
  robot.respond /勤怠(.*)/i, (msg) ->
    username = msg.message.user.name
    fullName = getUserFullName(username)
    mail = getUserMail(username)
    text = msg.match[1]

    try
      sendMail(mail, fullName, text)
      msg.send "下記内容で勤怠連絡したよ！\nSubject: 勤怠管理 #{fullName}\nText: #{text}"

    catch error
      msg.send("送信失敗... 今日は休めないや..どんまい")
      msg.send("エラーメッセージ\n #{error}")



