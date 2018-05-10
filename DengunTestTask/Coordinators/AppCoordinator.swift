//
//  AppCoordinator.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 10.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

  init(_ window: UIWindow) {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }

  var rootViewController: UIViewController {
    return navihationController
  }

  let navihationController = UIViewController()
  var childCoordinators = [Coordinator]()

  func start() {
    
  }
}
