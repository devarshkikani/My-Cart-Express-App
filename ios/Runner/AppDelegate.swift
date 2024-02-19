import UIKit
import Flutter
import Firebase


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if (call.method == "disable") {
        UIScreen.main.isCapturedDidChange = { [weak self] in
          if UIScreen.main.isCaptured {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
          }
        }
        result(true)
      } else {       
        result(FlutterMethodNotImplemented)
      }
    }
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
      if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
     application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
