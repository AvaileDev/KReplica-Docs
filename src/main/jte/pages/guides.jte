@param io.availe.kreplicadocs.GuidesViewModel vm

@template.layout.main(
title = "Guides | KReplica Docs",
currentPage = vm.getCurrentPage(),
navLinks = vm.getNavLinks(),
properties = vm.getProperties(),
content = @`
    @template.partials.content-examples(vm = vm)
`
)