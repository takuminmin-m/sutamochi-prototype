class LoggerController < ApplicationController
  def start
    @study_log = StudyLog.new
    @study_log.start = true
    @study_log.save

    @user = User.first
    now = Time.now
    prompt = "あなたの彼氏である私（#{@user.name}）は昨日、#{now.hour}時#{now.min}分から勉強を始めました。
    今はちょうど、昨日勉強し始めたときと同じ時間です。
    今日も一緒に勉強するように誘ってください。"
    @message = miibo_generate(prompt)
    p @message
    StudyNotifyMailer.with(user: @user, message: @message).start_study_notify.deliver_later(wait: 1.second)

    render json: @study_log
  end

  def finish
    @study_log = StudyLog.new
    @study_log.start = false
    @study_log.save

    render json: @study_log
  end

  def index
    @study_logs = StudyLog.all

    render json: @study_logs
  end
end
