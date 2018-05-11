//
//  ProfileDetailsCollectionViewCellViewModel.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift

enum ProfileDetailsCollectionViewCellViewModelType {
  case profileDetails
  case followers
  case nutrition
}

protocol ProfileDetailsCollectionViewCellViewModelProtocol {
  var type: ProfileDetailsCollectionViewCellViewModelType { get }
//  var profileItemsObservable: Observable<[ProfileInfoItem]> { get }
}

class ProfileDetailsCollectionViewCellViewModel: ProfileDetailsCollectionViewCellViewModelProtocol {
  var type: ProfileDetailsCollectionViewCellViewModelType = .profileDetails

  var profileItemsObservable: Observable<[ProfileInfoItem]>

  init(itemsObservable: Observable<[ProfileInfoItem]>) {
    profileItemsObservable = itemsObservable
  }
}

class FollowersCollectionViewCellViewModel: ProfileDetailsCollectionViewCellViewModelProtocol {
  var type: ProfileDetailsCollectionViewCellViewModelType = .followers

  var followersItemsObservable: Observable<[SearchQueryItem]>

  init(itemsObservable: Observable<[SearchQueryItem]>) {
    followersItemsObservable = itemsObservable
  }
}

class NutritionCollectionViewCellViewModel: ProfileDetailsCollectionViewCellViewModelProtocol {
  var type: ProfileDetailsCollectionViewCellViewModelType = .nutrition

  var followersItemsObservable: Observable<[NutritionDataItem]>

  init(itemsObservable: Observable<[NutritionDataItem]>) {
    followersItemsObservable = itemsObservable
  }
}

