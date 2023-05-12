//
//  AppDelegate.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import UIKit

// Note: You might see warning: "This method should not be called on the main thread as it
// may lead to UI unresponsiveness.". It can be ignored for now, as it is a known issue
// when using WKWebView.
// https://stackoverflow.com/questions/74038451/in-xcode-14-ios-16-purple-warnings-starting-with-this-method-should-not-be-ca

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ExploreViewController())
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

