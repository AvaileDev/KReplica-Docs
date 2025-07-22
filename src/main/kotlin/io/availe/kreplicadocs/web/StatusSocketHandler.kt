package io.availe.kreplicadocs.web

import org.springframework.stereotype.Component
import org.springframework.web.socket.TextMessage
import org.springframework.web.socket.WebSocketSession
import org.springframework.web.socket.handler.TextWebSocketHandler

@Component
class StatusSocketHandler : TextWebSocketHandler() {

    override fun afterConnectionEstablished(session: WebSocketSession) {
        println("Session Established: ${session.id}")
        session.sendMessage(TextMessage("Connection to KReplica Docs server successful!"))
    }

    override fun handleTextMessage(session: WebSocketSession, message: TextMessage) {
        println("Received message from ${session.id}: ${message.payload}")
        session.sendMessage(TextMessage("Message received: '${message.payload}'"))
    }
}