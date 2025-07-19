package io.availe.demo.usage

import io.availe.lytte.models.UserAccountSchema

fun handleUserV1(user: UserAccountSchema.V1) {
    when (user) {
        is UserAccountSchema.V1.CreateRequest -> TODO()
        is UserAccountSchema.V1.Data -> TODO()
        is UserAccountSchema.V1.PatchRequest -> TODO()
    }
}

fun handleUserPatchVariants(user: UserAccountSchema.PatchRequestVariant) {
    when (user) {
        is UserAccountSchema.V1.PatchRequest -> TODO()
        is UserAccountSchema.V2.PatchRequest -> TODO()
    }
}

fun handleAllUserTypes(user: UserAccountSchema) {
    when (user) {
        is UserAccountSchema.V1.CreateRequest -> TODO()
        is UserAccountSchema.V2.CreateRequest -> TODO()
        is UserAccountSchema.V1.Data -> TODO()
        is UserAccountSchema.V2.Data -> TODO()
        is UserAccountSchema.V1.PatchRequest -> TODO()
        is UserAccountSchema.V2.PatchRequest -> TODO()
    }
}