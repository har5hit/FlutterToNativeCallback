/*
 * Created by Harshith Shetty on 4/4/19 5:20 PM.
 * Copyright (c) 2019 People Interactive. All rights reserved.
 *
 */
package com.shaaditech.webviewbridge2

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.FrameLayout
import android.widget.Toast
import io.flutter.facade.Flutter
import io.flutter.plugin.common.MethodChannel


class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val flutterView = Flutter.createView(
            this@MainActivity,
            lifecycle,
            ""
        )
        val layout =
            FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT)
        addContentView(flutterView, layout)

        val channel = MethodChannel(flutterView, "webview")
        channel.setMethodCallHandler { call, result ->
            Toast.makeText(baseContext,call.arguments.toString(),Toast.LENGTH_SHORT).show()
            Log.d(TAG, "arguments: ${call.arguments}")
            result.success("")
        }
    }
    private val TAG = "MainActivity";
}
