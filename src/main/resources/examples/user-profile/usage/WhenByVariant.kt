package io.availe.demo.usage

import io.availe.lytte.models.UserAccountSchema

// By using a local variant interface like `PatchRequestVariant`,
// you can handle all patch requests across all versions.
fun handleUserPatchVariants(user: UserAccountSchema.PatchRequestVariant) {
    when (user) {
        is UserAccountSchema.V1.PatchRequest -> TODO()
        is UserAccountSchema.V2.PatchRequest -> TODO()
    }
}