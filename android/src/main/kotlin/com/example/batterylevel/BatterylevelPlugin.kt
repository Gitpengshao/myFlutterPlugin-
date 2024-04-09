package com.example.batterylevel

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.getSystemService

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** BatterylevelPlugin */
class BatterylevelPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    // 获取上下文对象
    private var applicationContext: Context? = null

    private var activity: Activity? = null

    // 注册插件到flutter引擎
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        // 上下文对象
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "batterylevel")
        channel.setMethodCallHandler(this)
    }

    //跳转原生页面
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }


    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        resultMethod = null
        channel.setMethodCallHandler(null)
    }


    companion object {
        var resultMethod: Result? = null
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        // 判断通信方法的名称，实现获取平台版本
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "getBatteryLevel") {
            // 返回电量
            val batteryLevel = getBatteryLevel()
            if (batteryLevel != -1) {
                result.success(batteryLevel)
            }
        } else if (call.method == "getValueByAndroid") {
            val flutterTag = call.arguments as? String
            result.success("Android返回flutter的数据\nflutter传入tag=$flutterTag")
        } else if (call.method == "intentToAndroidView") {
            resultMethod = result
            val loginTag = call.arguments as? String
            val intent = Intent(applicationContext, LoginActivity::class.java)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            if (loginTag != null) {
                intent.putExtra("loginTag", loginTag)
            }
            applicationContext?.startActivity(intent)
        } else {
            result.notImplemented()
        }
    }


    // 获取电池电量
    private fun getBatteryLevel(): Int {
        var batteryLevel = -1
        batteryLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager =
                applicationContext?.let { getSystemService(it, BatteryManager::class.java) }
            batteryManager!!.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null, IntentFilter(
                    Intent.ACTION_BATTERY_CHANGED
                )
            )
            (intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                ?: -1) * 100 / (intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                ?: -1)
        }

        return batteryLevel
    }


}
