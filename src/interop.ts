import "./styles.css";

export const flags = async () => ({});
export const onReady = () => {};

customElements.define(
  "live-region",
  class LiveRegion extends HTMLElement {
    static observedAttributes = ["content"];
    constructor() {
      super();
    }

    attributeChangedCallback(
      name: string,
      _oldValue: string,
      newValue: string
    ) {
      if (name === "content") {
        setTimeout(() => {
          this.textContent = newValue;
        }, 200);
      }
    }
  }
);
