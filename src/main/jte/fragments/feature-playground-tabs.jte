@param io.availe.kreplicadocs.Example featureExample
@param String activeFile
@param boolean oob = false

<div class="playground-tabs" role="tablist" id="feature-playground-tabs"
     hx-swap-oob="${oob ? "outerHTML" : null}">
    <button role="tab"
            aria-selected="${"source".equals(activeFile)}"
            class="${"source".equals(activeFile) ? "active" : ""}"
            hx-get="/examples/${featureExample.getSlug()}/file/source"
            hx-target="#feature-playground-content-wrapper .playground-content"
            hx-swap="innerHTML">
        1. Define Interface
    </button>
    <button role="tab"
            aria-selected="${"UserAccountSchema.kt".equals(activeFile)}"
            class="${"UserAccountSchema.kt".equals(activeFile) ? "active" : ""}"
            hx-get="/examples/${featureExample.getSlug()}/file/UserAccountSchema.kt"
            hx-target="#feature-playground-content-wrapper .playground-content"
            hx-swap="innerHTML">
        2. Generate DTOs
    </button>
    <button role="tab"
            aria-selected="${"Mapper.kt".equals(activeFile)}"
            class="${"Mapper.kt".equals(activeFile) ? "active" : ""}"
            hx-get="/examples/${featureExample.getSlug()}/usage/Mapper.kt"
            hx-target="#feature-playground-content-wrapper .playground-content"
            hx-swap="innerHTML">
        3. Integrate Mapper
    </button>
    <button role="tab"
            aria-selected="${"Evolve.kt".equals(activeFile)}"
            class="${"Evolve.kt".equals(activeFile) ? "active" : ""}"
            hx-get="/examples/${featureExample.getSlug()}/usage/Evolve.kt"
            hx-target="#feature-playground-content-wrapper .playground-content"
            hx-swap="innerHTML">
        4. Evolve with &#96;when&#96;
    </button>
</div>
