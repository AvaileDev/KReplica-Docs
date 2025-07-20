@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug
@param java.util.List<io.availe.kreplicadocs.NavLink> navLinks
@param io.availe.kreplicadocs.AppProperties properties

@template.layout.main(
title = "Playground | KReplica Docs",
currentPage = "playground",
navLinks = navLinks,
properties = properties,
content = @`
    @template.partials.content-playground(
    example = example,
    allExamples = allExamples,
    activeSlug = activeSlug
    )
`
)