package io.availe.kreplicadocs.web

import com.fasterxml.jackson.databind.ObjectMapper
import io.availe.kreplicadocs.model.CompileResponse
import io.availe.kreplicadocs.services.CompilationBrokerService
import org.springframework.stereotype.Component
import org.springframework.web.socket.CloseStatus
import org.springframework.web.socket.TextMessage
import org.springframework.web.socket.WebSocketSession
import org.springframework.web.socket.handler.TextWebSocketHandler

@Component
class StatusSocketHandler(
    private val objectMapper: ObjectMapper,
    private val compilationBroker: CompilationBrokerService
) : TextWebSocketHandler() {

    override fun afterConnectionEstablished(session: WebSocketSession) {
        println("Server: Sandbox client connected: ${session.id}")
        compilationBroker.registerSandboxClient(session)
    }

    override fun handleTextMessage(session: WebSocketSession, message: TextMessage) {
        val response = objectMapper.readValue(message.payload, CompileResponse::class.java)
        compilationBroker.completeJob(response)
    }

    override fun afterConnectionClosed(session: WebSocketSession, status: CloseStatus) {
        println("Server: Sandbox client disconnected: ${session.id}")
        compilationBroker.deregisterSandboxClient()
    }
}