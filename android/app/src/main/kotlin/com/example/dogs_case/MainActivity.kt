package com.example.dogs_case

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity()

import kotlin.random.Random
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "callNewChannel").setMethodCallHandler {
      call, result ->
        if(call.method == "getSystemVersion") {
          var rand = android.os.Build.VERSION.RELEASE;
          result.success(rand)
        }
        else {
          result.notImplemented()
        }
    }
  }
}
