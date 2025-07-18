@template.layout.main(
title = "Examples | KReplica Docs",
currentPage = "examples",
content = @`
    <div class="examples-layout">
        <aside class="examples-sidebar">
            <div class="sidebar-nav">
                <h3>Examples</h3>
                <ul>
                    <li><a href="#non-versioned">Non-Versioned Model</a></li>
                    <li><a href="#versioned">Versioned Model</a></li>
                    <li><a href="#direct-annotations">Direct Annotations</a></li>
                    <li><a href="#serializable">Serializable</a></li>
                    <li><a href="#hide-annotation">Hide Annotation</a></li>
                    <li><a href="#contextual-nested">Contextual Nested Models</a></li>
                </ul>
            </div>
        </aside>

        <div class="examples-main">
            <h1>Examples</h1>
            <p>These examples cover the primary use cases of KReplica, from basic model generation to advanced features like versioning and serialization.</p>

            <section id="non-versioned">
                <h2>Example (non-versioned)</h2>
                <p>This example covers how to use the <code>Replicate.Model</code> and <code>Replicate.Property</code> annotations.</p>
                @template.tags.code(language="kotlin", content=@`
                    @OptIn(ExperimentalUuidApi::class)
                    @Replicate.Model(
                    variants = [DtoVariant.DATA, DtoVariant.CREATE, DtoVariant.PATCH], // required argument
                    nominalTyping = NominalTyping.ENABLED // disabled by default
                    )
                    private interface UserAccount {
                    // This property inherits all of @Replicate.Model's arguments
                    val emailAddress: String

                    // This property is only included in the DATA variant
                    @Replicate.Property(include = [DtoVariant.DATA])
                    val id: Uuid

                    // This property is excluded from the CREATE variant
                    @Replicate.Property(exclude = [DtoVariant.CREATE])
                    val banReason: Patchable<List<String?>>

                    // We opt out of nominalTyping for this property
                    @Replicate.Property(nominalTyping = NominalTyping.DISABLED)
                    val userDescription: String?
                    }
                `)
            </section>

            <section id="versioned">
                <h2>Example (versioned)</h2>
                <p>To version a <code>Replicate.Model</code> declaration, create a base interface (e.g. <code>UserAccount</code>) and extend it with <code>V&lt;number&gt;</code> interfaces (e.g. <code>V1</code>, <code>V2</code>) to track model changes.</p>
                @template.tags.code(language="kotlin", content=@`
                    private interface UserAccount

                    @Replicate.Model(variants = [DtoVariant.DATA])
                    private interface V1 : UserAccount {
                    val id: Int
                    }

                    @Replicate.Model(variants = [DtoVariant.DATA, DtoVariant.PATCH])
                    private interface V2 : UserAccount {
                    val id: Int
                    val name: String
                    }
                `)
                <p>If you wish to not follow the <code>V&lt;number&gt;</code> naming convention, you must use the <code>Replicate.SchemaVersion</code> annotation to manually specify a version number.</p>
                @template.tags.code(language="kotlin", content=@`
                    private interface UserAccount

                    @Replicate.Model(variants = [DtoVariant.DATA, DtoVariant.PATCH])
                    @Replicate.SchemaVersion(1)
                    private interface NewAccount : UserAccount {
                    val id: Int
                    val name: String
                    }
                `)
            </section>

            <section id="direct-annotations">
                <h2>Directly applying annotations</h2>
                <p>If the annotation can be applied on interfaces, you can directly use it without the need for <code>Replicate.Apply</code>.</p>
                @template.tags.code(language="kotlin", content=@`
                    @Replicate.Model(variants = [DtoVariant.DATA])
                    @Deprecated("Use NewUserAccount instead")
                    private interface UserAccount {
                    @Deprecated("Use newId instead")
                    val id: Int
                    }
                `)
            </section>

            <section id="serializable">
                <h2>Example (serializable)</h2>
                <p>Interfaces cannot directly implement some annotations, including <code>Serializable</code>. Instead, you can use <code>Replicate.Apply</code>.</p>
                @template.tags.code(language="kotlin", content=@`
                @OptIn(ExperimentalTime::class)
                @Replicate.Model(variants = [DtoVariant.DATA], autoContextual = AutoContextual.DISABLED)
                @Replicate.Apply([Serializable::class])
                private interface V1 : UserAccount {
                val id: Int

                // here we manually apply contextual, as it inherits the model's AutoContextual.DISABLED
                @Contextual
                val startTime: Instant

                // here we manually specify which serializer we want to use
                @Serializable(with = InstantAsStringSerializer::class)
                val midTime: Instant

                // here we override autoContextual to be ENABLED and let KReplica apply it automatically
                @Replicate.Property(autoContextual = AutoContextual.ENABLED)
                val endTime: List<List<Instant>>
                    }
                    `)
            </section>

            <section id="hide-annotation">
                <h2>The hide annotation</h2>
                <p>The <code>@Replicate.Hide</code> annotation stops a <code>Replicate.Model</code> declaration from being generated. It's mainly for temporarily testing how code removal affects the system.</p>
                @template.tags.code(language="kotlin", content=@`
                    @Replicate.Model(variants = [DtoVariant.DATA])
                    @Replicate.Hide
                    private interface UserAccount {
                    val id: Int
                    }
                `)
            </section>

            <section id="contextual-nested">
                <h2>Contextual nested models</h2>
                <p>You can use other KReplica-managed schemas as properties. KReplica will automatically use the correct variant (DATA for DATA, CREATE for CREATE, etc.) in the generated code.</p>
                <p>For a versioned nested model:</p>
                @template.tags.code(language="kotlin", content=@`
                    @Replicate.Model(variants = [DtoVariant.DATA, DtoVariant.CREATE, DtoVariant.PATCH])
                    private interface AdminAccount {
                    val user: UserAccountSchema.V1
                    }
                `)
                <p>For a non-versioned nested model:</p>
                @template.tags.code(language="kotlin", content=@`
                    @Replicate.Model(variants = [DtoVariant.DATA, DtoVariant.CREATE, DtoVariant.PATCH])
                    private interface AdminAccount {
                    val user: UserAccountSchema
                    }
                `)
            </section>
        </div>
    </div>
`
)