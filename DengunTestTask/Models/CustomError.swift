//
//  CustomError.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

struct CustomError: LocalizedError {
  let value: String
  var localizedDescription: String {
    return value
  }
}
