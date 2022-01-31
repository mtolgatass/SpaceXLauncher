//
//  AppDelegate.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 30.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ListViewController()
        window?.makeKeyAndVisible()
        
        //Dummy test to see if any leak at first screen
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
        //            guard let self = self else { return }
        //            let vc = TestViewController()
        //            self.window?.rootViewController = vc
        //        }
        
        return true
    }
}

