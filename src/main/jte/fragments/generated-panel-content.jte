@param io.availe.kreplicadocs.Example example
@param String activeFile

@if(example.getGeneratedFiles().size() > 1)
    <div class="panel-tabs">
        @for (var entry : example.getGeneratedFiles().entrySet())
            @template.tags.tab-button(
            label = entry.getKey(),
            isActive = entry.getKey().equals(activeFile),
            hxGet = "/examples/${example.getSlug()}/generated-panel/${entry.getKey()}",
            hxTarget = "#generated-panel-${example.getSlug()}"
            )
        @endfor
    </div>
@endif
<div class="panel-content">
    @if(activeFile != null)
        @template.tags.code(language="kotlin", content=@`${example.getGeneratedFiles().get(activeFile)}`)
    @endif
</div>