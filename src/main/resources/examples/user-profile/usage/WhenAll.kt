package io.availe.demo.usage

import io.availe.lytte.models.UserAccountSchema

// Using the top-level schema interface forces the `when`
// expression to be fully exhaustive, guaranteeing that you
// handle every possible version and variant.
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