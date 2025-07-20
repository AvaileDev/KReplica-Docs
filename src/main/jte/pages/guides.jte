@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param io.availe.kreplicadocs.Example example = null
@param String activeSlug = null
@param java.util.List<io.availe.kreplicadocs.NavLink> navLinks

@template.layout.main(
title = "Guides | KReplica Docs",
currentPage = "guides",
navLinks = navLinks,
content = @`
    @template.partials.content-examples(allExamples = allExamples, example = example, activeSlug = activeSlug)
`
)