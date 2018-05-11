//
//  ProfileInfoItem.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol InfoItem {
  var title: String { get }
  var value: String { get }
}

enum ProfileInfoItem: InfoItem {
  case rank(String)
  case level(Int)
  case points(Int)
  case workouts(Int)
  case trainingTime(String)
  case triningSince(String)
  case followers(Int)

  var title: String {
    switch self {
    case .followers:
      return "Followers"
    case .level:
      return "Level"
    case .points:
      return "Points"
    case .rank:
      return "Rank"
    case .trainingTime:
      return "Training time"
    case .triningSince:
      return "Training since"
    case .workouts:
      return "Workouts"
    }
  }

  var value: String {
    switch self {
    case .rank(let value):
      return value
    case .level(let value):
      return "\(value)"
    case .points(let value):
      return "\(value)"
    case .workouts(let value):
      return "\(value)"
    case .trainingTime(let value):
      return "\(value)"
    case .triningSince(let value):
      return value
    case .followers(let value):
      return "\(value)"
    }
  }
}
