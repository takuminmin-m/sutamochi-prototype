class StudyStartNotifyJob < ApplicationJob
  queue_as :default

  def perform(user)
    now = Time.now
    logs = StudyLog.where(updated_at: now.yesterday..now).order(:id).to_a
    study_times = []
    time_all24 = 0
    for i in 0...logs.length
      next unless !logs[i].start && i > 0 && logs[i-1].start
      start = logs[i-1].created_at
      finish = logs[i].created_at
      diff = float_to_time(finish-start)
      study_times << [start, finish, diff]
      time_all24 += finish - start
    end

    time_all24 = float_to_time(time_all24)

    erb_file = File.read(Rails.root.join('app', 'views', 'gpt-prompt', 'start_study_notify.text.erb'))
    erb = ERB.new(erb_file)
    prompt = erb.result_with_hash(
      user: user,
      study_times: study_times,
      now: now,
      time_all24: time_all24
    )

    puts prompt
    message = miibo_generate(prompt)
    # message = prompt
    puts message
    StudyNotifyMailer.with(user: user, message: message).start_study_notify.deliver_later()
  end


  private

  def float_to_time(f)
    Time.local(2000, 1, 1, f/3600, f/60%60, f%60)
  end

  # TODO: 書く場所を統一
  def miibo_generate(prompt)
    request_headers = {
      'Content-Type' => 'application/json'
    }
    request_params = {
      api_key: Rails.application.credentials.miibo_miharu[:api_key],
      agent_id: Rails.application.credentials.miibo_miharu[:agent_id],
      utterance: prompt,
    }

    uri = URI.parse('https://api-mebo.dev/api')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === 'https'

    response = http.post(uri.path, request_params.to_json, request_headers)
    response_json = JSON.parse(response.body, symbolize_names: true)

    response_json[:bestResponse][:utterance]
  end
end
