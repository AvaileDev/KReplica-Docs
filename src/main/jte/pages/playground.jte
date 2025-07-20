@param io.availe.kreplicadocs.model.PlaygroundViewModel vm

@template.layout.main(
title = "Playground | KReplica Docs",
vm = vm,
content = @`
    @template.partials.content-playground(
    vm = vm
    )
`
)