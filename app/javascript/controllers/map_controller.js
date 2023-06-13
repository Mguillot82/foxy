import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    console.log(this.apiKeyValue)
    console.log(this.markerValue)

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkerToMap()
  }

  #addMarkerToMap() {
      new mapboxgl.Marker()
        .setLngLat([ this.markerValue.lng, this.markerValue.lat ])
        .addTo(this.map)
  }
}
