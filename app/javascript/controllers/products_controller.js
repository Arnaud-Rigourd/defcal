import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="products"
export default class extends Controller {
  static targets = ["product", "productName", "productCode", "containerForm", "researchTrigger", "mainTitle"]

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

    if(this.target.nodeName === "LI") {
      this.target.setAttribute('id', 'active')
    } else {
      this.target.parentElement.setAttribute('id', 'active')
    }
  }

  display(e) {
    // Reveal research bar
    this.containerFormTarget.style = "height: 180px"
    this.containerFormTarget.style.transform = "translateY(-50px)"

    // Hide h2 & h4
    this.researchTriggerTarget.style = "opacity: 0"
    this.researchTriggerTarget.style.transform = "translateY(-200px)"
    this.mainTitleTarget.style = "opacity: 0"
    this.mainTitleTarget.style.transform = "translateY(-200px)"
  }
}
