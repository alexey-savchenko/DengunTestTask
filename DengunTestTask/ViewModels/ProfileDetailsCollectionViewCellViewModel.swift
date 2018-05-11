//
//  ProfileDetailsCollectionViewCellViewModel.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift

protocol ProfileDetailsCollectionViewCellViewModelType {
  var profileItemsObservable: Observable<[ProfileInfoItem]> { get }
}

class ProfileDetailsCollectionViewCellViewModel: ProfileDetailsCollectionViewCellViewModelType {
  var profileItemsObservable: Observable<[ProfileInfoItem]>

  init(itemsObservable: Observable<[ProfileInfoItem]>) {
    profileItemsObservable = itemsObservable
  }
}
