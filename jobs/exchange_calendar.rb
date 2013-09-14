require 'viewpoint'
include Viewpoint::EWS

SCHEDULER.every '1m' do |job|

	cli = Viewpoint::EWSClient.new settings.ewsEndpoint, settings.ewsUser, settings.ewsPassword
	now = Time.now
	roomEvents = cli.get_user_availability([settings.ewsUser],
	                                       start_time: now.iso8601,
	                                       end_time: (now + 48*3600).iso8601,
	                                       time_zone: {bias: settings.timeZoneBias},
	                                       requested_view: :detailed_merged).calendar_event_array
	events = Array.new
	roomEvents.each_with_index.map {|roomEvent|
	  events.push(Hash[:start => (Time.parse(cli.event_start_time(roomEvent))),
	                   :title => roomEvent[:calendar_event][:elems][3][:calendar_event_details][:elems][1][:subject][:text]])
	}
	send_event('exchange_calendar', events: events[0..1])
end