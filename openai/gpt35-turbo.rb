require "./openai/openai.rb"

client = OpenAI::Client.new

response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "Hello!"}], # Required.
        temperature: 0.7,
    })

puts "sent: Hello!"
p response
