@param io.availe.kreplicadocs.model.view.GuideViewModel vm

<div class="examples-container">
    <aside class="examples-sidebar">
        @template.fragments.guide-sidebar(vm = vm)
    </aside>
    <div class="guide-main-content">
        @template.partials.guide-content(snippets = vm.getSnippets())
    </div>
</div>