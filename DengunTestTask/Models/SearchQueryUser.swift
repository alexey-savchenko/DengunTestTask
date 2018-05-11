//
//  SearchQueryUser.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 10.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SearchQueryItem {
  let id, friendRequestType: Int
  let countryName, city, name: String
  let fullName, photo: String
}

extension SearchQueryItem {
  init?(_ json: JSON) {
    id = json["id"].intValue
    friendRequestType = json["friend_request_type"].intValue
    countryName = json["friend"]["country_name"].stringValue
    city = json["friend"]["city"].stringValue
    name = json["friend"]["name"].stringValue
    fullName = json["friend"]["full_name"].stringValue
    photo = json["friend"]["photo"].stringValue
  }
}
