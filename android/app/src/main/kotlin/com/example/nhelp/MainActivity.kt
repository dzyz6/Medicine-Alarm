package com.example.nhelp

import androidx.activity.OnBackPressedCallback
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val CHANNEL = "pop_gesture";
    private lateinit var channel: MethodChannel
    private var eventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setStreamHandler(object :EventChannel.StreamHandler{
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink=events
            }

            override fun onCancel(arguments: Any?) {
                eventSink=null
            }
        })


    }

    override fun onBackPressed() {
        // 1. 发送事件到 Flutter
        eventSink?.success("callBack")

//        // 2. 执行默认返回（注释掉就可以拦截返回，不退出页面）
//        super.onBackPressed()
    }
}

