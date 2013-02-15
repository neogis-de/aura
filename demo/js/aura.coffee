jQuery ->
    map = L.map('map').setView([60.184167, 24.949167], 11)
    L.tileLayer('http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png',
        maxZoom: 18,
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
    ).addTo(map)
    url = 'http://localhost:5000/api/snowplows?callback=?'
    plough_icon = L.icon(
        iconUrl: 'img/bulldozer-helblue.png'
        iconSize: [32, 37]
        iconAnchor: [16, 35]
        popupAnchor: [0, -37]
    )
    moment.lang('fi')
    refresh_ploughs = ->
      console.log "refr"
        
    $.getJSON(url, (data) ->
        console.log "got data for #{ data.length } ploughs"
        for plough in data
            loc = plough.last_loc
            marker = L.marker([loc.coords[1], loc.coords[0]],
                icon: plough_icon
            )
            ts = moment(loc.timestamp).calendar()
            marker.bindPopup("<b>#{ plough.id }</b><br />Sijainti päivitetty #{ ts }")
            marker.addTo(map)
    )
