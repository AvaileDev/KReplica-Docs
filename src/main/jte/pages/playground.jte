@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug
@param java.util.List<io.availe.kreplicadocs.NavLink> navLinks

@template.layout.main(
title = "Playground | KReplica Docs",
currentPage = "playground",
navLinks = navLinks,
content = @`
    @template.partials.content-playground(
    example = example,
    allExamples = allExamples,
    activeSlug = activeSlug
    )
`
)