package com.xz.testflutter

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCodec

class MainActivity: FlutterActivity() {

//    private val flutterView by lazy { findViewById<FlutterView>(FLUTTER_VIEW_ID) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine?.dartExecutor,"").setMethodCallHandler { call, result ->
            call.method
        }

        EventChannel(flutterEngine?.dartExecutor,"").setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                events?.success("")
            }

            override fun onCancel(arguments: Any?) {

            }

        })
    }
}
