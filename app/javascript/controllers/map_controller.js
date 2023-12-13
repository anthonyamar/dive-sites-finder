import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = ["locations", "diveCenterMarkerUrl", "diveSiteMarkerUrl"]
  
  static values = {
    locations: Object,
    diveCenterMarkerUrl: String,
    diveSiteMarkerUrl: String
  }

  connect() {
    const locations = JSON.parse(this.data.get("locations"));
    this.initializeMap(locations);
  }

  initializeMap(locations) {
    this.map = L.map('map');
    this.map.setView([locations[0].latitude, locations[0].longitude], 15);
    
    L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
      maxZoom: 19,
      attribution: "OpenStreetMap",
    }).addTo(this.map);
    
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
        icon: locations[i].type === "dive_site" ? diveSiteMarker : diveCenterMarker
      }).addTo(this.map);
      
      marker.bindPopup(locations[i].popup);
      (i == 0) && marker.openPopup(); 
    }
  }

  findPopupByCoordinates(map, latlng) {
    let targetPopup = null;

    // Utilisez eachLayer pour parcourir tous les calques de la carte
    map.eachLayer((layer) => {
      // Vérifiez si le calque est un popup et si ses coordonnées correspondent
      console.log(layer)
      if (layer instanceof L.Popup && layer.getLatLng().equals(latlng)) {
        targetPopup = layer;
      }
    });
    
    return targetPopup;
  }

  setCenter({ params: {latitude, longitude} }) { 
    const coordinates = [latitude, longitude]
    const popup = this.findPopupByCoordinates(this.map, coordinates);
    
    this.map.panTo(coordinates, 15);
    console.log(popup)
    popup.openPopup();
  }
}
