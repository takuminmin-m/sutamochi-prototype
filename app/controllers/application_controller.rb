class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

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
