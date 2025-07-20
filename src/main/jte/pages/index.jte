@param io.availe.kreplicadocs.Example featureExample = null
@param java.util.List<io.availe.kreplicadocs.NavLink> navLinks
@param io.availe.kreplicadocs.AppProperties properties

@template.layout.main(
currentPage = "index",
navLinks = navLinks,
properties = properties,
content = @`
    @template.partials.content-index(featureExample = featureExample)
`
)