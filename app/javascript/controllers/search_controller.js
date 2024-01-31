import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  
  static targets = [
    "algoliaAppId", 
    "algoliaSearchKey",
  ]
  
  static values = {
    algoliaAppId: String,
    algoliaSearchKey: String,
  }
  
  connect() {
    console.log(this.data.get("algoliaAppId"))
    console.log(this.data.get("algoliaSearchKey"))
  }
}
