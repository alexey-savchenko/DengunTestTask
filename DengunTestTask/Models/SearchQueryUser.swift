//
//  SearchQueryUser.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 10.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

struct SearchQueryItem: Codable {
  let id, friendRequestType: Int
  let friend: Friend

  enum CodingKeys: String, CodingKey {
    case id
    case friendRequestType = "friend_request_type"
    case friend
  }
}

struct Friend: Codable {
  let countryName, city, name: String
  let id: Int
  let fullName, photo: String

  enum CodingKeys: String, CodingKey {
    case countryName = "country_name"
    case city, name, id
    case fullName = "full_name"
    case photo
  }
}
