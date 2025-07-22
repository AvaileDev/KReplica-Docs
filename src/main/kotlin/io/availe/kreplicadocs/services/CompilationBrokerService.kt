package io.availe.kreplicadocs.services

import io.availe.kreplicadocs.model.CompileRequest
import io.availe.kreplicadocs.model.CompileResponse
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.stereotype.Service
import org.springframework.web.socket.TextMessage
import org.springframework.web.socket.WebSocketSession
import java.util.UUID
import java.util.concurrent.CompletableFuture
import java.util.concurrent.ConcurrentHashMap

@Service
class CompilationBrokerService(private val objectMapper: ObjectMapper) {

    private var sandboxSession: WebSocketSession? = null
    private val pendingJobs = ConcurrentHashMap<String, CompletableFuture<CompileResponse>>()

    fun registerSandboxClient(session: WebSocketSession) {
        sandboxSession = session
    }

    fun deregisterSandboxClient() {
        sandboxSession = null
        pendingJobs.forEach { (_, future) ->
            future.completeExceptionally(IllegalStateException("Sandbox client disconnected."))
        }
        pendingJobs.clear()
    }

    fun submitJob(sourceCode: String): CompletableFuture<CompileResponse> {
        val session = sandboxSession
            ?: throw IllegalStateException("Sandbox client is not connected.")

        if (!session.isOpen) {
            throw IllegalStateException("Sandbox client session is closed.")
        }

        val jobId = UUID.randomUUID().toString()
        val future = CompletableFuture<CompileResponse>()
        pendingJobs[jobId] = future

        val request = CompileRequest(jobId = jobId, sourceCode = sourceCode)
        val jsonRequest = objectMapper.writeValueAsString(request)
        session.sendMessage(TextMessage(jsonRequest))

        return future
    }

    fun completeJob(response: CompileResponse) {
        pendingJobs.remove(response.jobId)?.complete(response)
    }
}