//
//  ProfileInfoItem.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

enum ProfileInfoItem {
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
}
