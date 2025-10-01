package com.PayChoice.Member360

import io.flutter.plugin.common.EventChannel

class OpenpathStreamHandler : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        eventSink?.success(mapOf("event" to "ready", "data" to "Openpath stream connected"))
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    fun sendEvent(event: String, data: Any?) {
        eventSink?.success(mapOf("event" to event, "data" to data))
    }
}
