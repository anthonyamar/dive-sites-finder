import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = ["locations", "diveCenterMarkerUrl", "diveSiteMarkerUrl"]
  
  static values = {
    locations: Object,
    diveCenterMarkerUrl: String,
    diveSiteMarkerUrl: String
  }

  connect() {
    const locations = JSON.parse(this.data.get("locations"))
    
    const map = L.map('map');
    map.setView([locations[0].latitude, locations[0].longitude], 15);
    
    L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
      maxZoom: 19,
      attribution: "OpenStreetMap",
    }).addTo(map);
    
    const diveSiteMarker = L.icon({
      iconUrl: this.data.get("diveSiteMarkerUrl"),
      iconSize: [38, 38],
    })

    const diveCenterMarker = L.icon({
      iconUrl: this.data.get("diveCenterMarkerUrl"),
      iconSize: [38, 38],
    })

    for (var i = 0; i < locations.length; i++) {
      var marker = L.marker([locations[i].latitude, locations[i].longitude], {
        icon: locations[i].type === "site" ? diveSiteMarker : diveCenterMarker
      }).addTo(map);
      
      marker.bindPopup(locations[i].popup);
      (i == 0) && marker.openPopup(); 
    }
  }

  setCenter({ params: {latitude, longitude} }) { 
    console.log("Bonjour de setCenter")
    if (map) {
      map.flyTo([latitude, longitude], 15);
    } else {
      console.log("no")
    }
  }
}
