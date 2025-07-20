@param io.availe.kreplicadocs.PlaygroundViewModel vm

@template.layout.main(
title = "Playground | KReplica Docs",
currentPage = vm.getCurrentPage(),
navLinks = vm.getNavLinks(),
properties = vm.getProperties(),
content = @`
    @template.partials.content-playground(
    example = vm.getExample(),
    exampleSelectOptions = vm.getExampleSelectOptions()
    )
`
)