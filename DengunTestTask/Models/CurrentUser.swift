//
//  User.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 10.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

struct CurrentUser: Codable {
  let points, workouts, level: Int
  let bio: String
  let id, numFollowers: Int
  let rankLabel: String
  let trainingTime: Int
  let city, fullName, trainingSince: String
  let nutrition: Nutrition

  enum CodingKeys: String, CodingKey {
    case points, workouts, level, bio, id
    case numFollowers = "num_followers"
    case rankLabel = "rank_label"
    case trainingTime = "training_time"
    case city
    case fullName = "full_name"
    case trainingSince = "training_since"
    case nutrition
  }
}

struct Nutrition: Codable {
  let waterMax: String
  let dailyCaloricNeeds: Int
  let goal: String
  let id, protein, fat: Int
  let waterMin: String
  let user: Int
  let weight: String
  let carbs: Int
  let goalLabel: String

  enum CodingKeys: String, CodingKey {
    case waterMax = "water_max"
    case dailyCaloricNeeds = "daily_caloric_needs"
    case goal, id, protein, fat
    case waterMin = "water_min"
    case user, weight, carbs
    case goalLabel = "goal_label"
  }
}
