
setupMap = ->
    window.mymap = L.map('mapid',
        center: [33.137551, 36.386718]
        zoom: maps.zoom
        wheelPxPerZoomLevel: 200
    )

    L.Icon.Default.imagePath = 'leaflet-icons/'
    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}',
        maxZoom: 18
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> ' +
              'contributors, ' + '<a href="https://creativecommons.org/licenses/by-sa/2.0/">' +
              'CC-BY-SA</a>, ' + 'Imagery © ' +
              '<a href="https://www.mapbox.com/">Mapbox</a>'
        id: 'mapbox.streets'
        accessToken: 'pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw'
    ).addTo window.mymap


addLocations = ->
    maps.locations.forEach (item) ->
        if item[1] != null and item[2] != null
            new L.marker([item[1], item[2]])
                .bindPopup(item[0])
                .addTo window.mymap

clickOnMap = (e) ->
    L.popup()
        .setLatLng(e.latlng)
        .setContent('You clicked the map at ' + e.latlng.toString())
        .openOn window.mymap
    # mymap.on('click', onMapClick);

$(document).on 'turbolinks:load', ->
    return unless page.controller() == 'maps' && (page.action() == 'map_view' || page.action() == 'peek_preview')
    console.log 'Loaded map view!'

    window.maps = $('#map-data').data()
    return unless maps != undefined

    setupMap()
    addLocations()
