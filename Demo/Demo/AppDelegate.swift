//
//  AppDelegate.swift
//  Demo
//
//  Created by Alan on 2022/5/9.
//

import UIKit
import moduledframe
import moduleH5
import moduleUser
import moduleUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //测试moduleH5
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = INS_TestModuleH5ViewController()
        let rootViewController = INS_NavigationViewController.init(rootViewController: vc)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        INS_UIGlobal.shared.setRootWindow(window)
        
        //测试modulemframe
        Test.test()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

