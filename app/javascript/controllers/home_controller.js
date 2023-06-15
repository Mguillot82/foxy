import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ['camera', 'photo', 'button_picture', 'buttons_accept_refuse', 'animal']

  connect() {
    navigator.geolocation
    .getCurrentPosition((position) => {
      this.latitude = position.coords.latitude;
      this.longitude = position.coords.longitude;
    });

    navigator.mediaDevices
       .getUserMedia({video: {width: screen.width, height: screen.height}})
      //.getUserMedia({video: {width: screen.height - 190 , height: screen.width, facingMode: { exact: "environment" }}})
      .then((stream) => {
        this.stream = stream
        this.cameraTarget.srcObject = stream;
        this.cameraTarget.play();
    })
    .catch((err) => {
      console.error(`An error occurred: ${err}`);
    });
  }

  take_photo(event) {
    event.preventDefault();
    this.takePicture();
    this.photoTarget.classList.remove('d-none');
    this.buttons_accept_refuseTarget.classList.remove('d-none');
    this.cameraTarget.classList.add('d-none');
    this.button_pictureTarget.classList.add('d-none');
  }

  takePicture() {
    canvas.width = this.cameraTarget.videoWidth;
    canvas.height = this.cameraTarget.videoHeight;
    canvas.getContext('2d').drawImage(this.cameraTarget, 0, 0, canvas.width, canvas.height);
    let image_data_url = canvas.toDataURL('image/jpeg');
    photo.setAttribute("src", image_data_url);
    this.stream.getTracks().forEach(function(track) {
      track.stop();
    });
  }

  refuse() {
    this.photoTarget.classList.add('d-none');
    this.buttons_accept_refuseTarget.classList.add('d-none');
    this.cameraTarget.classList.remove('d-none');
    this.button_pictureTarget.classList.remove('d-none');
    this.connect();
  }

  accept() {
    let photo = this.photoTarget.src
    let base64ImageContent = photo.replace(/^data:image\/(png|jpg|jpeg);base64,/, "");
    let blob = this.base64ToBlob(base64ImageContent, 'image/jpeg');
    let formData = new FormData();
    formData.set('image', blob);
    formData.set('fields', 'all')
    fetch("https://api.inaturalist.org/v2/computervision/score_image",{
      method: "POST",
      headers: {'accept': 'application/json',
                'Authorization': 'eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjo2OTk3OTkzLCJleHAiOjE2ODY4MzQ4NzN9.nIQFMpykg3RViW-DPwasVcigCV89rxNO3FYvIvv4sHep90WBEar2xNn-qxEntCxQgycWNBbYOB1RDMAgEq0IaA'},
      body: formData
      })
    .then(response => response.json())
    .then((api_data) => {
      this.api_data = api_data;
      let wiki_url = api_data.results[0].taxon.wikipedia_url
      let token = document.getElementsByName('csrf-token')[0].content;

      fetch('/animals/get_loc_desc', {
        method: "POST",
        headers: {'accept': 'application/json',
                  'Content-Type': 'application/json',
                  'X-CSRF-Token': token},
        body: JSON.stringify({'wiki_url': wiki_url})
      })
      .then(response => response.json())
      .then((data) => {
        this.desc_loc_data = data
        this.photoTarget.classList.add('d-none');
        this.buttons_accept_refuseTarget.classList.add('d-none');
        this.animalTarget.classList.remove('d-none');

        fetch('/animals/new?' + new URLSearchParams({
          'animal[name]': api_data.results[0].taxon.english_common_name,
          'animal[scientific_name]': api_data.results[0].taxon.name,
          'animal[photo_url]': api_data.results[0].taxon.default_photo.medium_url,
          'animal[description]': this.desc_loc_data.description,
      }), {
          headers: {"Accept": "text/plain"}
        })
        .then(response => response.text())
        .then((data) => {
          this.animalTarget.outerHTML = data
        })
      })
    })
  }

  createTaxonomy() {
    let token = document.getElementsByName('csrf-token')[0].content;
    let taxonomy = this.api_data.results[0].taxon.iconic_taxon_name;
    fetch('/taxonomies', {
      method: "POST",
      headers : {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      body: JSON.stringify({'taxonomy': {'name': taxonomy}})
    })
    .then(response => response.json())
    .then((taxon_data) => {
      this.#createAnimal(this.api_data, taxon_data);
    })
  }

  #createAnimal(api_data, taxon_data) {

    let token = document.getElementsByName('csrf-token')[0].content;
    let animal_name = api_data.results[0].taxon.english_common_name;
    let animal_scientific_name = api_data.results[0].taxon.name;
    let animal_taxon = taxon_data.id;
    let animal_photo = api_data.results[0].taxon.default_photo.medium_url;
    let animal_description = this.desc_loc_data.description;
    let animal_location = this.desc_loc_data.image_url;

    fetch('/animals', {
      method: "POST",
      headers : {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      body: JSON.stringify({'animal': {'name': animal_name, "scientific_name": animal_scientific_name, "description": animal_description, "location": animal_location, "taxonomy_id": animal_taxon, "photo_url": animal_photo }})
    })
    .then(response => response.json())
    .then((animal_data) => {
      console.log(animal_data);
      this.#createCatch(api_data, taxon_data, animal_data);
    })
  }

  #createCatch(api_data, taxon_data, animal_data) {
    let token = document.getElementsByName('csrf-token')[0].content;
    let photo = this.photoTarget.src
    let base64ImageContent = photo.replace(/^data:image\/(png|jpg|jpeg);base64,/, "");
    let blob = this.base64ToBlob(base64ImageContent, 'image/jpeg');
    let formData = new FormData();
    formData.set('catch[photo]', blob);
    formData.set('catch[animal_id]', animal_data.id);
    formData.set('catch[latitude]', this.latitude);
    formData.set('catch[longitude]', this.longitude);
    // this.uploadFile(formData)
    fetch('/catches', {
      method: "POST",
      headers : {
        'Accept': 'application/json',
        'enctype': "multipart/form-data",
        'X-CSRF-Token': token
      },
      body: formData
    })
    .then(response => response.json())
    .then((catch_data) => {
      let animal_id = catch_data.animal_id
      let catch_id = catch_data.id
      window.location.href = 'catches/'+ catch_id + '/animals/'+ animal_id
    })
  }

  base64ToBlob(base64, mime)
  {
    mime = mime || '';
    var sliceSize = 1024;
    var byteChars = window.atob(base64);
    var byteArrays = [];

    for (var offset = 0, len = byteChars.length; offset < len; offset += sliceSize) {
        var slice = byteChars.slice(offset, offset + sliceSize);

        var byteNumbers = new Array(slice.length);
        for (var i = 0; i < slice.length; i++) {
            byteNumbers[i] = slice.charCodeAt(i);
        }

        var byteArray = new Uint8Array(byteNumbers);

        byteArrays.push(byteArray);
    }

    return new Blob(byteArrays, {type: mime});
  }
}
