@param io.availe.kreplicadocs.Example featureExample = null
@param java.util.List<io.availe.kreplicadocs.NavLink> navLinks

@template.layout.main(
currentPage = "index",
navLinks = navLinks,
content = @`
    @template.partials.content-index(featureExample = featureExample)
`
)