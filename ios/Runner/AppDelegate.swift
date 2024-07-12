// import UIKit
// import Flutter
// import FirebaseCore
// import FirebaseMessaging

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     FirebaseApp.configure()
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    
    // Add platform channel
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let securityChannel = FlutterMethodChannel(name: "com.example.security",
                                              binaryMessenger: controller.binaryMessenger)
    securityChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "enableScreenshotProtection" {
        self.enableScreenshotProtection()
        result(nil)
      } else if call.method == "disableScreenshotProtection" {
        self.disableScreenshotProtection()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func enableScreenshotProtection() {
    if let window = self.window {
      window.isSecureTextEntry = true
    }
  }

  private func disableScreenshotProtection() {
    if let window = self.window {
      window.isSecureTextEntry = false
    }
  }
}
