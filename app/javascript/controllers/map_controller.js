import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("coucou from map_controller.js")
    
    mapboxgl.accessToken = "pk.eyJ1IjoiYW50aG9ueWFtYXIiLCJhIjoiY2xvb3Vhb3I5MDRzbjJpbzZ3aXpiY3JlOCJ9.P7fK9W5NaG4f2GK3OPMNzg"
    
    const map = new mapboxgl.Map({
      container: 'map',
      style: "mapbox://styles/anthonyamar/cloovcybq00h501pl5uho0vp1", 
      center: [-70, 43],
      zoom: 13
    });
    
    
  }
}
