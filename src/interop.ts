import "./styles.css";

// This returns the flags passed into your Elm application
export const flags = async ({ env }: ElmLand.FlagsArgs) => {
  return {};
};

// This function is called after your Elm app starts
export const onReady = ({ app, env }: ElmLand.OnReadyArgs) => {
  console.log("Elm is ready", app);
  app.ports.outgoing.subscribe((data) => {
    switch (data.tag) {
      case "FOCUS_HTML_ID":
        document.getElementById(data.data as string)?.focus();
        break;
    }
  });
};

// Type definitions for Elm Land
namespace ElmLand {
  export type FlagsArgs = {
    env: Record<string, string>;
  };
  export type OnReadyArgs = {
    env: Record<string, string>;
    app: {
      ports: {
        outgoing: {
          subscribe: (
            callback: (data: { tag: string; data: unknown }) => void
          ) => void;
        };
      };
    };
  };
}

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
      setTimeout(() => {
        this.textContent = this.getAttribute("message");
      }, 200);
    }
  }
);
