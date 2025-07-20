@param io.availe.kreplicadocs.IndexViewModel vm

@template.layout.main(
currentPage = vm.getCurrentPage(),
navLinks = vm.getNavLinks(),
properties = vm.getProperties(),
content = @`
    @template.partials.content-index(vm = vm)
`
)