//
//  TimeInterval+Extensions.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

extension TimeInterval {
  func toString() -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .abbreviated
    let formattedString = formatter.string(from: self)
    return formattedString ?? ""
  }
}
