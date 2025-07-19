@file:OptIn(ExperimentalUuidApi::class)

package io.availe.demo

import io.availe.Replicate
import io.availe.models.DtoVariant
import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid

private interface UserAccount {
    @Replicate.Model(
        variants = [DtoVariant.DATA, DtoVariant.PATCH, DtoVariant.CREATE],
    )
    private interface V1 : UserAccount {
        @Replicate.Property(include = [DtoVariant.DATA])
        val id: Uuid
        val firstName: String
        val lastName: String
        val email: String
    }

    @Replicate.Model(
        variants = [DtoVariant.DATA, DtoVariant.PATCH, DtoVariant.CREATE],
    )
    private interface V2 : UserAccount {
        @Replicate.Property(include = [DtoVariant.DATA])
        val id: Uuid
        val firstName: String
        val lastName: String
        val email: String
    }
}