class LoggerController < ApplicationController
  def start
    @study_log = StudyLog.new
    @study_log.start = true
    @study_log.save

    user = User.first
    now = Time.now
    tomorrow_now = now + 3600*24 - 1000

    StudyStartNotifyJob.set(wait_until: tomorrow_now).perform_later(user)
    # StudyStartNotifyJob.perform_later(user)

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
