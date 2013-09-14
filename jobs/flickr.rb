require 'open-uri'
require 'nokogiri'

SCHEDULER.every '20s' do |job|
  public_photos = photo_urls "public", settings.flickr_id
  favourite_photos = photo_urls "faves", settings.flickr_id
  send_event('flickr_public', photos: public_photos)
  send_event('flickr_faves', photos: favourite_photos)
end

def photo_urls(type, flickr_id)
      doc=Nokogiri::HTML(open("http://ycpi.api.flickr.com/services/feeds/photos_#{type}.gne?id=#{flickr_id}"))
      photos = Array.new;
      doc.css('entry link').each do |link|
        if (link.attr('rel') == 'enclosure')
          photos.push(link.attr('href'))
        end
      end
      photos
end