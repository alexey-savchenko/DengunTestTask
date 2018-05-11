//
//  UserHomeControllerViewModel.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 10.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

protocol UserHomeControllerViewModelType {
  // Inputs
  var userpicSelected: PublishSubject<UIImage> { get }

  // Outputs
  var tabItems: [String] { get }
  var currentUserData: Observable<CurrentUser> { get }
  var profileItemsData: Observable<[ProfileInfoItem]> { get }
  var profileImage: Observable<UIImage> { get }
}

final class UserHomeControllerViewModel: UserHomeControllerViewModelType {

  // MARK: Init and deinit
  init(_ fetchService: FetchService) {
    service = fetchService

    userpicSelected
      .do(onNext: saveImage)
      .observeOn(MainScheduler.instance)
      .subscribe(userpicSubject)
      .disposed(by: disposeBag)
  }

  // Properties
  private let service: FetchService
  private let disposeBag = DisposeBag()
//  private let userpicSubject = BehaviorSubject<UIImage>(value: #imageLiteral(resourceName: "default-user-avatar"))
  lazy var userpicSubject: BehaviorSubject<UIImage> = {
    return BehaviorSubject<UIImage>(value: getLocalImage() ?? #imageLiteral(resourceName: "default-user-avatar"))
  }()

  // Outputs
  var currentUserData: Observable<CurrentUser> {
    return service.getCurrentUser()
  }
  var profileItemsData: Observable<[ProfileInfoItem]> {
    return currentUserData.flatMapLatest(convertUserToProfileItems)
  }
  var profileImage: Observable<UIImage> {
    return userpicSubject.asObservable()
  }

  var tabItems = ["PROFILE", "FOLLOWERS", "NUTRION"]

  // Inputs
  var userpicSelected = PublishSubject<UIImage>()

  private func convertUserToProfileItems(_ user: CurrentUser) -> Observable<[ProfileInfoItem]> {
    return Observable.create { observer in
      var resultArray = [ProfileInfoItem]()

      resultArray.append(.rank(user.rankLabel))
      resultArray.append(.level(user.level))
      resultArray.append(.points(user.points))
      resultArray.append(.workouts(user.workouts))
      resultArray.append(.trainingTime(TimeInterval(user.trainingTime).toString()))
      resultArray.append(.triningSince(user.trainingSince))

      observer.onNext(resultArray)
      return Disposables.create()
    }
  }

  private func getLocalImage() -> UIImage? {
    let targetURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("userpic.jpg")
    let data = try? Data(contentsOf: targetURL)
    if let imageData = data {
      return UIImage(data: imageData)
    } else {
      return nil
    }
  }

  private func saveImage(_ image: UIImage) {
    DispatchQueue.global().async {
      if let imageData = UIImageJPEGRepresentation(image, 0.8) {
        let targetURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("userpic.jpg")
        do {
          try imageData.write(to: targetURL)
        } catch {
          print(error)
        }
      }
    }
  }
}
