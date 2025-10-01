import UIKit
import Flutter
import Firebase
// Do NOT import OpenpathMobile here; the bridge file handles it.

@main
@objc class AppDelegate: FlutterAppDelegate {

  private var displayLink: CADisplayLink?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Firebase
    FirebaseApp.configure()

    // Flutter root controller
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Optional: 120Hz display link for smoother UI on ProMotion devices
    displayLink = CADisplayLink(target: self, selector: #selector(displayLinkCallback))
    displayLink?.add(to: .current, forMode: .default)
    if #available(iOS 15.0, *) {
      displayLink?.preferredFrameRateRange = CAFrameRateRange(minimum: 120, maximum: 120, preferred: 120)
    }

    // (Legacy) Status bar control channel
    // Note: setStatusBarHidden is deprecated on iOS 13+; keep only if you rely on it.
    let statusBarChannel = FlutterMethodChannel(
      name: "com.moffatman.chan/statusBar",
      binaryMessenger: controller.binaryMessenger
    )
    statusBarChannel.setMethodCallHandler { call, result in
      switch call.method {
      case "showStatusBar":
        application.setStatusBarHidden(false, with: .fade)
        result(nil)
      case "hideStatusBar":
        application.setStatusBarHidden(true, with: .fade)
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    // 🔴 OpenPath bridge disabled temporarily
   if let registrar = self.registrar(forPlugin: "openpath_bridge") {
     let moduleName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Runner"
     if let pluginType = NSClassFromString("\(moduleName).OpenpathBridge") as? FlutterPlugin.Type {
       pluginType.register(with: registrar)
     } else {
       NSLog("⚠️ OpenpathBridge not found. Ensure OpenpathBridge.swift is in the project and has Runner target membership.")
     }
   }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  @objc private func displayLinkCallback() {
    // no-op
  }
}
