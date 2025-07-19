@param io.availe.kreplicadocs.Example featureExample
@param gg.jte.Content tabs
@param gg.jte.Content initialContent

<div class="examples-shell"
     id="feature-playground"
     x-data="{ maxHeight: 0 }"
     x-init="$nextTick(() => { maxHeight = $refs.contentArea.offsetHeight; })">

    <div class="playground-tabs-wrapper">
        <div class="playground-tabs" role="tablist">
            ${tabs}
        </div>
    </div>
    <div id="feature-playground-content-wrapper"
         class="playground-content-fixed-height"
         x-ref="contentArea"
         :style="maxHeight > 0 && { 'max-height': maxHeight + 'px' }">
        <div class="playground-content">
            ${initialContent}
        </div>
    </div>
</div>