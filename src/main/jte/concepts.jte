@template.layout.main(
title = "Core Concepts | KReplica Docs",
currentPage = "concepts",
content = @`
    <h1>Core Concept: Sealed Hierarchies</h1>
    <p>KReplica generates sealed interfaces, allowing you to leverage exhaustive <code>when</code> expressions for robust and type-safe code. This makes handling different versions or variants straightforward and ensures you don't miss cases.</p>
    <p>In <strong>example 2 (versioned schema)</strong>, if you check the generated code, here is a short snippet of what you will see:</p>

    @template.tags.code(language="kotlin", content=@`
        public sealed interface V2 : UserAccountSchema {
        public data class Data(
        public val id: Int,
        public val name: String,
        public val schemaVersion: Int = 2,
        ) : V2,
        DataVariant
    `)

    <p>This code snippet might seem a bit complex for a single DTO, but it's key to enabling powerful, type-safe pattern matching across different schema versions and variants.</p>

    <h3>Example: Exhaustively handle all schema versions and variants</h3>
    @template.tags.code(language="kotlin", content=@`
        fun handleUser(user: UserAccountSchema) {
        when (user) {
        is UserAccountSchema.V1.Data -> TODO()
        is UserAccountSchema.V2.Data -> TODO()
        is UserAccountSchema.V2.PatchRequest -> TODO()
        }
        }
    `)

    <h3>Example: Exhaustively handle only a specific schema version</h3>
    @template.tags.code(language="kotlin", content=@`
        fun handleUser(user: UserAccountSchema.V2) {
        when (user) {
        is UserAccountSchema.V2.Data -> TODO()
        is UserAccountSchema.V2.PatchRequest -> TODO()
        }
        }
    `)

    <h3>Example: Exhaustively handle only a specific kind of variant</h3>
    @template.tags.code(language="kotlin", content=@`
        fun handleUser(user: UserAccountSchema.DataVariant) {
        when (user) {
        is UserAccountSchema.V1.Data -> TODO()
        is UserAccountSchema.V2.Data -> TODO()
        }
        }
    `)

    <h3>Example: Target only a specific schema version and specific variant</h3>
    @template.tags.code(language="kotlin", content=@`
        fun handleUser(user: UserAccountSchema.V1.Data) {
        print(user.id)
        }
    `)
`
)