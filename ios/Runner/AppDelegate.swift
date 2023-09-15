import UIKit
import Flutter
import flutter_downloader
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      
      if #available(iOS 10.0, *) {

          UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in

              DispatchQueue.main.async {
                  UIApplication.shared.registerForRemoteNotifications()
              }

          }

      }
      
    GMSServices.provideAPIKey("AIzaSyB0AW2vBqSKJPqegh75EhUUxPljXPhaxqU")
    GeneratedPluginRegistrant.register(with: self)
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}


