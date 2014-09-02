window.overlay = undefined
window.img = 'https://www.lib.utexas.edu/maps/historical/newark_nj_1922.jpg'

boundsChangedHandler = (e) ->
  window.overlay.setMap(null) if window.overlay
  window.overlay = drawGroundOverlay(this.map, window.img, this.getBounds())

drawControl = (map, bounds) ->
  new google.maps.Rectangle
    map: map
    bounds: bounds
    strokeOpacity: 0.8,
    strokeWeight: 2,
    fillOpacity: 0.0,
    draggable: true,
    editable: true

drawGroundOverlay = (map, url, bounds) ->
  overlay = new google.maps.GroundOverlay(url, bounds)
  overlay.setMap(map)
  overlay

initialize = =>
  newark = new google.maps.LatLng(40.740, -74.18)
  bounds = new google.maps.LatLngBounds(new google.maps.LatLng(40.712216, -74.22655), new google.maps.LatLng(40.773941, -74.12544))
  mapOptions = { zoom: 13, center: newark }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

  control = drawControl(map, bounds)
  window.overlay = drawGroundOverlay(map, window.img, bounds)

  google.maps.event.addListener(control, 'bounds_changed', boundsChangedHandler)

google.maps.event.addDomListener(window, 'load', initialize)
