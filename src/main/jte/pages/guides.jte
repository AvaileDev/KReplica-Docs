@param io.availe.kreplicadocs.model.GuidesViewModel vm

@template.layout.main(
title = "Guides | KReplica Docs",
vm = vm,
content = @`
    @template.partials.content-examples(vm = vm)
`
)