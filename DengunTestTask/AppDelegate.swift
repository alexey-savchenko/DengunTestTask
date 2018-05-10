//
//  AppDelegate.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 08.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: AppCoordinator?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    appCoordinator = AppCoordinator(window!)
    appCoordinator?.start()
    
    return true
  }
}
