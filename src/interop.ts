import "./styles.css";

export const flags = async () => ({});
export const onReady = () => {};

customElements.define(
  "route-announcer",
  class LiveRegion extends HTMLElement {
    static observedAttributes = ["message"];
    private timeout: number | null = null;
    constructor() {
      super();
    }

    connectedCallback() {
      this.setAttribute("aria-live", "polite");
      this.setAttribute("role", "status");
      this.setAttribute("class", "sr-only");
      this.update();
    }
    attributeChangedCallback() {
      this.update();
    }

    update() {
      this.textContent = "";
      if (this.timeout) {
        clearTimeout(this.timeout);
      }
      this.timeout = setTimeout(() => {
        this.textContent = this.getAttribute("message");
      }, 200);
    }
  }
);
