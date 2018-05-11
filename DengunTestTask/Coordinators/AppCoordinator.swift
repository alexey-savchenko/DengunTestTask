//
//  AppCoordinator.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 10.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
  init(_ window: UIWindow) {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }

  var rootViewController: UIViewController {
    return navigationController
  }

  let navigationController = UINavigationController()
  var childCoordinators = [Coordinator]()

  func start() {
    let userHomeControllerViewModel = UserHomeControllerViewModel(MockFetchService())
    let userHomeController = UserHomeController(userHomeControllerViewModel)
    navigationController.setViewControllers([userHomeController], animated: false)
  }
}
