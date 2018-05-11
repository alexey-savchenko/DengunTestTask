//
//  NutrionDataItem.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

enum NutritionDataItem {
  case goal(String)
  case weight(String)
  case dailyCaloricNeeds(Int)
  case protein(Int)
  case carbs(Int)
  case fat(Int)
  case water(String)

  var title: String {
    switch self {
    case .goal:
      return "Goal"
    case .weight:
      return "Weight"
    case .dailyCaloricNeeds:
      return "Daily caloric needs"
    case .protein:
      return "Protein"
    case .carbs:
      return "Carbs"
    case .fat:
      return "Fat"
    case .water:
      return "Water"
    }
  }
}
