@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param io.availe.kreplicadocs.Example example = null
@param String activeSlug = null
@param java.util.List<io.availe.kreplicadocs.NavLink> navLinks
@param io.availe.kreplicadocs.AppProperties properties

@template.layout.main(
title = "Guides | KReplica Docs",
currentPage = "guides",
navLinks = navLinks,
properties = properties,
content = @`
    @template.partials.content-examples(allExamples = allExamples, example = example, activeSlug = activeSlug)
`
)