@param io.availe.kreplicadocs.model.view.GuideViewModel vm

@template.layout.main(
title = "Guide | KReplica Docs",
vm = vm,
content = @`
    @template.partials.content-guide(vm = vm)
`
)