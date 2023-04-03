class LoggerController < ApplicationController
  def start
    @study_log = StudyLog.new
    @study_log.start = true
    @study_log.save

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
