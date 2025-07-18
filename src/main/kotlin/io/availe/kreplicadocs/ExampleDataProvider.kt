package io.availe.kreplicadocs

import jakarta.annotation.PostConstruct
import org.springframework.stereotype.Service

@Service
class ExampleDataProvider {

    private val examples = mutableListOf<Example>()

    @PostConstruct
    fun init() {
        examples.add(createNonVersionedExample())
        examples.add(createVersionedExample())
    }

    fun getAllExamples(): List<Example> = examples

    fun getExampleBySlug(slug: String): Example? = examples.find { it.slug == slug }

    private fun createNonVersionedExample(): Example {
        val source = """
@OptIn(ExperimentalUuidApi::class)
@Replicate.Model(
  variants = [DtoVariant.DATA, DtoVariant.CREATE, DtoVariant.PATCH],
  nominalTyping = NominalTyping.ENABLED
)
private interface UserAccount {
  val emailAddress: String

  @Replicate.Property(include = [DtoVariant.DATA])
  val id: Uuid

  @Replicate.Property(exclude = [DtoVariant.CREATE])
  val banReason: Patchable<List<String?>>

  @Replicate.Property(nominalTyping = NominalTyping.DISABLED)
  val userDescription: String?
}
        """.trimIndent()

        val schema = """
@file:OptIn(ExperimentalUuidApi::class)

package io.availe.demo

import io.availe.models.Patchable
import kotlin.OptIn
import kotlin.String
import kotlin.collections.List
import kotlin.jvm.JvmInline
import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid

public sealed interface UserAccountSchema {
  public data class Data(
    public val emailAddress: UserAccountEmailAddress,
    public val id: UserAccountId,
    public val banReason: UserAccountBanReason,
    public val userDescription: String?,
  ) : UserAccountSchema

  public data class CreateRequest(
    public val emailAddress: UserAccountEmailAddress,
    public val userDescription: String?,
  ) : UserAccountSchema

  public data class PatchRequest(
    public val emailAddress: Patchable<UserAccountEmailAddress> = Patchable.Unchanged,
    public val banReason: Patchable<UserAccountBanReason> = Patchable.Unchanged,
    public val userDescription: Patchable<String?> = Patchable.Unchanged,
  ) : UserAccountSchema
}
        """.trimIndent()

        val valueClasses = """
@JvmInline
public value class UserAccountBanReason(
  public val `value`: Patchable<List<String?>>,
)

@JvmInline
public value class UserAccountEmailAddress(
  public val `value`: String,
)

@JvmInline
public value class UserAccountId(
  public val `value`: Uuid,
)
        """.trimIndent()

        return Example(
            name = "Non-Versioned Model",
            slug = "non-versioned",
            description = "This example covers how to use the <code>@Replicate.Model</code> and <code>@Replicate.Property</code> annotations for a simple, non-versioned model.",
            sourceCode = source,
            generatedFiles = mapOf(
                "UserAccountSchema.kt" to schema,
                "ValueClasses.kt" to valueClasses
            )
        )
    }

    private fun createVersionedExample(): Example {
        val source = """
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
        """.trimIndent()

        val generated = """
package io.availe.demo

import io.availe.models.Patchable
import kotlin.Int
import kotlin.String

public sealed interface UserAccountSchema {
  public sealed interface DataVariant : UserAccountSchema

  public sealed interface PatchRequestVariant : UserAccountSchema

  public sealed interface V1 : UserAccountSchema {
    public data class Data(
      public val id: Int,
      public val schemaVersion: Int = 1,
    ) : V1, DataVariant
  }

  public sealed interface V2 : UserAccountSchema {
    public data class Data(
      public val id: Int,
      public val name: String,
      public val schemaVersion: Int = 2,
    ) : V2, DataVariant

    public data class PatchRequest(
      public val id: Patchable<Int> = Patchable.Unchanged,
      public val name: Patchable<String> = Patchable.Unchanged,
      public val schemaVersion: Patchable<Int> = Patchable.Unchanged,
    ) : V2, PatchRequestVariant
  }
}
        """.trimIndent()

        return Example(
            name = "Versioned Model",
            slug = "versioned",
            description = "This example demonstrates how to create evolving models with versioning. KReplica generates a sealed hierarchy to handle different versions gracefully.",
            sourceCode = source,
            generatedFiles = mapOf(
                "UserAccountSchema.kt" to generated
            )
        )
    }
}