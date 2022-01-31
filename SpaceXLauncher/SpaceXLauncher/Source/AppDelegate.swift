//
//  AppDelegate.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 29.01.2022.
//

import UIKit
import Apollo

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ListViewController()
        window?.makeKeyAndVisible()
        
        Network.shared.apollo.fetch(query: LaunchesPastQuery()) { result in
          switch result {
          case .success(let graphQLResult):
            print("Success! Result: \(graphQLResult)")
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
        return true
    }
}
