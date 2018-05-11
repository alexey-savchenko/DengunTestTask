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

      if let jsonURL = Bundle.main.url(forResource: "user_profile", withExtension: "json", subdirectory: nil, localization: nil),
        let jsonData = try? Data(contentsOf: jsonURL) {
        do {
          let currentUser = try JSONDecoder().decode(CurrentUser.self, from: jsonData)
          observer.onNext(currentUser)
        } catch {
          observer.onError(CustomError(value: "Unable to decode JSON."))
          print(error)
        }
      } else {
        observer.onError(CustomError(value: "Unable to read local JSON data."))
      }
      return Disposables.create()
    }
  }

  func getFollowers() -> Observable<[SearchQueryItem]> {
    return Observable.create { observer in

      

      return Disposables.create()
    }
  }
}
