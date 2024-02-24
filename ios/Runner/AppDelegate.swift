import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "callNewChannel",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
  [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
  guard call.method == "getSystemVersion" else {
    result(FlutterMethodNotImplemented)
    return
  }
  self?.getIosVersion(result: result)
})

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getIosVersion(result: FlutterResult) {
  var systemVersion = UIDevice.current.systemVersion
  result(String(systemVersion))
}
}


