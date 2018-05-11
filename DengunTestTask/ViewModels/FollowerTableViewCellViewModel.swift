//
//  FollowerTableViewCellViewModel.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol FollowerTableViewCellViewModelType {
  var locationString: String { get }
  var userpicURL: URL { get }
  var name: String { get }
  var id: Int { get }
}

class FollowerTableViewCellViewModel: FollowerTableViewCellViewModelType {
  init(_ item: SearchQueryItem) {
    if item.city != "" {
      locationString = "\(item.countryName), \(item.city)"
    } else {
      locationString = "\(item.countryName)"
    }
    userpicURL = URL(string: item.photo)!
    name = item.fullName
    id = item.id
  }
  var locationString: String
  var userpicURL: URL
  var name: String
  var id: Int

}
