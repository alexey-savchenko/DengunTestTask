//
//  OtherUser.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 10.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

struct OtherUser: Codable {
  let points, workouts, level: Int
  let birthdate, bio: String
  let id, numFollowers: Int
  let rankLabel: String
  let trainingTime: Int
  let fullName, trainingSince: String

  enum CodingKeys: String, CodingKey {
    case points, workouts, level, birthdate, bio, id
    case numFollowers = "num_followers"
    case rankLabel = "rank_label"
    case trainingTime = "training_time"
    case fullName = "full_name"
    case trainingSince = "training_since"
  }
}
