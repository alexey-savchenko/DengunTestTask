//
//  Services.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift

protocol FetchService {
  func getCurrentUser() -> Observable<CurrentUser>
  func getFollowers() -> Observable<[SearchQueryItem]>
}

class MockFetchService: FetchService {
  func getCurrentUser() -> Observable<CurrentUser> {
    return Observable.create { observer in
      
      return Disposables.create()
    }
  }

  func getFollowers() -> Observable<[SearchQueryItem]> {
    return Observable.create { observer in

      return Disposables.create()
    }
  }
}
