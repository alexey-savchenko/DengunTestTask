//
//  UIViewController+Extensions.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

extension UIViewController {
  func presentError(_ message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}
