import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="products"
export default class extends Controller {
  static targets = ["product", "productName", "productCode"]

  connect() {
    // this.productTargets.forEach ((product) => {
    //   console.log(product.dataset.productName)
    // })
  }

  addInfo(e) {
    this.target = e.target

    // autocomplete form

    this.productNameTarget.value = `${this.target.dataset.productName}`

    this.productCodeTarget.value = `${this.target.dataset.productCode}`

    // Set background color on target

    this.productTargets.forEach((product) => {
      product.removeAttribute('id', 'active')
    })

    this.target.setAttribute('id', 'active')
  }
}
