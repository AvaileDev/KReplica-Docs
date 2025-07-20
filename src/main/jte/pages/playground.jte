@param io.availe.kreplicadocs.Example example
@param java.util.List<io.availe.kreplicadocs.Example> allExamples
@param String activeSlug

@template.layout.main(
title = "Playground | KReplica Docs",
currentPage = "playground",
content = @`
    @template.partials.content-playground(
    example = example,
    allExamples = allExamples,
    activeSlug = activeSlug
    )
`
)