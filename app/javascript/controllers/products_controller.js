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

    this.productNameTarget.value = `${this.target.dataset.productName}`

    this.productCodeTarget.value = `${this.target.dataset.productCode}`
  }
}
