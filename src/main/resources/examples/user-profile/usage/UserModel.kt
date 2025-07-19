@file:OptIn(ExperimentalUuidApi::class)

package io.availe.lytte.domain

import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid

data class UserModel(
    val id: Uuid,
    val firstName: String,
    val lastName: String,
    val email: String,
) {
    init {
        require(firstName.isNotBlank()) { "firstName cannot be blank" }
        require(lastName.isNotBlank()) { "lastName cannot be blank" }
        require(EMAIL_REGEX.matches(email)) { "Invalid e-mail" }
    }

    fun changeName(newFirstName: String, newLastName: String): UserModel {
        return this.copy(
            firstName = newFirstName.trim(),
            lastName = newLastName.trim()
        )
    }

    fun changeEmail(newEmail: String): UserModel {
        return this.copy(email = newEmail.trim())
    }

    companion object {
        private val EMAIL_REGEX = Regex("""^[^\s@]+@[^\s@]+\.[^\s@]+$""")
    }
}