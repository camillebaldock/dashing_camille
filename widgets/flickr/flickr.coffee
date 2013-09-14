class Dashing.Flickr extends Dashing.Widget
 
  ready: ->
    @currentIndex = 0
    @photoElem = $(@node).find('.photo-container')
    @nextPhoto()
    @startCarousel()
 
  onData: (data) ->
    @currentIndex = 0
 
  startCarousel: ->
    setInterval(@nextPhoto, 10000)
 
  nextPhoto: =>
    photos = @get('photos')
    if photos
      @photoElem.fadeOut =>
        @currentIndex +=1
        @currentIndex -= photos.length if @currentIndex >= photos.length
        @set 'current_photo', photos[@currentIndex]
        @photoElem.fadeIn()