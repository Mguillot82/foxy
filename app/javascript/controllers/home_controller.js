import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ['camera', 'photo', 'button_picture', 'buttons_accept_refuse']

  connect() {
    navigator.geolocation
    .getCurrentPosition((position) => {
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;
    });

    navigator.mediaDevices
      .getUserMedia({video: true})
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
                'Authorization': 'eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjo2OTk3OTkzLCJleHAiOjE2ODYyMzc3MDh9.VpnwTIDJrwkqdyyaaGgebj1KWlUcKL4BXgpjh_r-QSe-hijfo-y3IL1YSZ2cfd7k3GXi15kgrGQpAIR2ZIJBBQ'},
      body: formData
      })
    .then(response => response.json())
    .then((api_data) => {
      this.#createTaxonomy(api_data)

    })
  }

  #createTaxonomy(api_data) {
    console.log(api_data)
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
