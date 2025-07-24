package io.availe.demo.usage

import io.availe.lytte.models.UserAccountSchema

// By typing the function parameter as `UserAccountSchema.V1`,
// the compiler ensures you handle all variants only within that version.
fun handleUserV1(user: UserAccountSchema.V1) {
    when (user) {
        is UserAccountSchema.V1.CreateRequest -> TODO()
        is UserAccountSchema.V1.Data -> TODO()
        is UserAccountSchema.V1.PatchRequest -> TODO()
    }
}