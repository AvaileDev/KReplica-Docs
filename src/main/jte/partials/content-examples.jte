@param io.availe.kreplicadocs.model.view.GuidesViewModel vm

<div class="guide-container">
    <div class="guide-main-content">
        @template.partials.guide-content(snippets = vm.getGuideSnippets())
    </div>
</div>