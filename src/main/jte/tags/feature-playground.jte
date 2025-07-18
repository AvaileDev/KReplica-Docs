@param io.availe.kreplicadocs.Example featureExample

<div class="examples-shell"
     id="feature-playground"
     x-data="{ maxHeight: 0 }"
     x-init="$nextTick(() => { maxHeight = $refs.contentArea.offsetHeight; console.log(maxHeight) })">

    <div class="playground-tabs-wrapper">
        <div class="playground-tabs" role="tablist">
            <button role="tab"
                    aria-selected="true"
                    class="active"
                    hx-get="/examples/${featureExample.getSlug()}/file/source"
                    hx-target="#feature-playground-content-wrapper"
                    hx-swap="innerHTML">
                1. Definition
            </button>
            @for(var entry : featureExample.getGeneratedFiles().entrySet())
                <button role="tab"
                        aria-selected="false"
                        hx-get="/examples/${featureExample.getSlug()}/file/${entry.getKey()}"
                        hx-target="#feature-playground-content-wrapper"
                        hx-swap="innerHTML">
                    @if(entry.getKey().contains("Schema"))
                        2. Generated DTO
                    @else
                        3. Benefits
                    @endif
                </button>
            @endfor
        </div>
    </div>
    <div id="feature-playground-content-wrapper"
         class="playground-content-fixed-height"
         x-ref="contentArea"
         :style="maxHeight > 0 && { 'max-height': maxHeight + 'px' }">
        <div class="playground-content">
            @template.tags.code(language="kotlin", content=@`
                ${featureExample.getSourceCode()}
            `)
        </div>
    </div>
</div>