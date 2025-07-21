@param io.availe.kreplicadocs.model.view.GuidesViewModel vm

<div class="examples-container">
    <aside class="examples-sidebar">
        @template.fragments.guide-sidebar()
    </aside>
    <div class="guide-main-content">
        @template.partials.guide-content(snippets = vm.getGuideSnippets())
    </div>
</div>