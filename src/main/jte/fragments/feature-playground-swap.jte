@param io.availe.kreplicadocs.model.ExampleViewModel featureExample
@param String activeFile
@param String language
@param String code

@template.fragments.feature-playground-tabs(featureExample = featureExample, activeFile = activeFile, oob = true)
@template.fragments.feature-tour-description(featureExample = featureExample, activeFile = activeFile, oob = true)
@template.fragments.playground-file-content(language = language, code = code)