require 'net/http'
require 'json'
require 'uri'

SCHEDULER.every '2m' do |job|
  uri = URI.parse("http://duolingo.com/users/#{settings.duolingo_user}")
  response = Net::HTTP.get_response(uri)
  languages_data = JSON.parse(response.body)["languages"]
  duolingo_report = Array.new
  languages_data.each do |language|
    if language["learning"]
      duolingo_report.push({ label: language["language_string"], value: language["points"]}) 
    end
  end
  duolingo_report.sort! { |a,b| b[:value] <=> a[:value] }
  send_event('duolingo', { items: duolingo_report })
end