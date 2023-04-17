class StudyNotifyMailer < ApplicationMailer
  default from: 'notify@example.com'

  def start_study_notify
    @user = params[:user]
    @message = params[:message]

    mail(to: @user.email, subject: '今から勉強しませんか？')
  end
end
