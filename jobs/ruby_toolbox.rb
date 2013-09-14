require 'nokogiri'
require 'open-uri'
require 'typhoeus'

SCHEDULER.every '1m' do |job|
	doc=Nokogiri::HTML(open("https://www.ruby-toolbox.com/categories/by_name"))
	category_links = doc.css('#content ul.group_items>li>a')
	hydra = Typhoeus::Hydra.new
	requests = Array.new
	category_links.each do |category_link|
		requests.push(Typhoeus::Request.new("https://www.ruby-toolbox.com"+category_link.attr('href')))
	end
	requests.map { |request| hydra.queue(request) }
	hydra.run
	gems = Array.new
	requests.each do |request|
		doc = Nokogiri::HTML(request.response.body)
		projects = doc.css('.project')
		projects.each do |project|
			gems.push({ name: project.css('.project-label').text, description: project.css('.description').text[0...300]})
		end
	end
	random_gem = gems.sample(1).first
	send_event('ruby_toolbox', gem: random_gem)
end