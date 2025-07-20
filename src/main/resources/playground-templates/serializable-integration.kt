package io.availe.demo.playground

import io.availe.Replicate
import io.availe.models.AutoContextual
import io.availe.models.DtoVariant
import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.time.Instant

private interface UserAccount

@Replicate.Model(variants = [DtoVariant.DATA], autoContextual = AutoContextual.DISABLED)
@Replicate.Apply([Serializable::class])
private interface V1 : UserAccount {
    val id: Int

    @Contextual
    val startTime: Instant

    @Replicate.Property(autoContextual = AutoContextual.ENABLED)
    val endTime: List<List<Instant>>
}