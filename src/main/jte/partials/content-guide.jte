@param io.availe.kreplicadocs.model.view.GuideViewModel vm

<div class="examples-container">
    <aside class="examples-sidebar">
        @template.fragments.guide-sidebar(vm = vm)
    </aside>
    <div class="guide-main-content">
        @template.partials.guide-content(snippets = vm.getGuideSnippets())

        <div id="examples-main" class="section-divider">
            @if (vm.getExample() != null)
                @template.fragments.example-playground(example = vm.getExample(), activeFile = "source")
            @else
                <div class="placeholder-text">
                    <p>Select an example to get started.</p>
                </div>
            @endif
        </div>
    </div>
</div>