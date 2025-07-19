@param io.availe.kreplicadocs.Example featureExample
@param String activeFile
@param boolean oob = false

<div id="feature-playground-tabs" hx-swap-oob="${oob ? "outerHTML" : null}">
    <div class="tour-part">
        <h3 class="tour-part-header">Part 1: Core Feature - Compile-Time Safety</h3>
        <div class="playground-tabs" role="tablist">
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
                    aria-selected="${"WhenStatements.kt".equals(activeFile)}"
                    class="${"WhenStatements.kt".equals(activeFile) ? "active" : ""}"
                    hx-get="/examples/${featureExample.getSlug()}/usage/WhenStatements.kt"
                    hx-target="#feature-playground-content-wrapper .playground-content"
                    hx-swap="innerHTML">
                3. Ensure Exhaustive Handling
            </button>
        </div>
    </div>
    <div class="tour-part">
        <h3 class="tour-part-header">Part 2: Advanced Pattern - Type-Safe Mappers</h3>
        <div class="playground-tabs" role="tablist">
            <button role="tab"
                    aria-selected="${"ApiSchemaMapper.kt".equals(activeFile)}"
                    class="${"ApiSchemaMapper.kt".equals(activeFile) ? "active" : ""}"
                    hx-get="/examples/${featureExample.getSlug()}/usage/ApiSchemaMapper.kt"
                    hx-target="#feature-playground-content-wrapper .playground-content"
                    hx-swap="innerHTML">
                1. The Generic Pattern
            </button>
            <button role="tab"
                    aria-selected="${"Mapper.kt".equals(activeFile)}"
                    class="${"Mapper.kt".equals(activeFile) ? "active" : ""}"
                    hx-get="/examples/${featureExample.getSlug()}/usage/Mapper.kt"
                    hx-target="#feature-playground-content-wrapper .playground-content"
                    hx-swap="innerHTML">
                2. The Implementation
            </button>
        </div>
    </div>
</div>