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
  var profileImage: Observable<UIImage> { get }
  var profileItemsData: Observable<[ProfileDetailsCollectionViewCellViewModelProtocol]> { get }
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

  // MARK: Properties
  private let service: FetchService
  private let disposeBag = DisposeBag()
  lazy var userpicSubject: BehaviorSubject<UIImage> = {
    return BehaviorSubject<UIImage>(value: getLocalImage() ?? #imageLiteral(resourceName: "default-user-avatar"))
  }()

  // Outputs
  var currentUserData: Observable<CurrentUser> {
    return service.getCurrentUser()
  }

  var profileImage: Observable<UIImage> {
    return userpicSubject.asObservable()
  }

  var profileItemsData: Observable<[ProfileDetailsCollectionViewCellViewModelProtocol]> {
    return Observable.just([
      ProfileDetailsCollectionViewCellViewModel(itemsObservable: currentUserData.flatMapLatest(convertUserToProfileItems)),
      FollowersCollectionViewCellViewModel(itemsObservable: service.getFollowers()),
      NutritionCollectionViewCellViewModel(itemsObservable: currentUserData.flatMapLatest(convertUserToNutritionItems))
      ])
  }

  var tabItems = ["PROFILE", "FOLLOWERS", "NUTRION"]

  // Inputs
  var userpicSelected = PublishSubject<UIImage>()

  // MARK: Functions
  private func convertUserToProfileItems(_ user: CurrentUser) -> Observable<[ProfileInfoItem]> {
    return Observable.create { observer in
      var resultArray = [ProfileInfoItem]()

      resultArray.append(.rank(user.rankLabel))
      resultArray.append(.level(user.level))
      resultArray.append(.points(user.points))
      resultArray.append(.workouts(user.workouts))
      resultArray.append(.trainingTime(TimeInterval(user.trainingTime).toString()))
      resultArray.append(.triningSince(user.trainingSince))
      resultArray.append(.followers(user.numFollowers))

      observer.onNext(resultArray)
      return Disposables.create()
    }
  }

  private func convertUserToNutritionItems(_ user: CurrentUser) -> Observable<[NutritionInfoItem]> {
    return Observable.create { observer in

      var resultArray = [NutritionInfoItem]()

      resultArray.append(.goal(user.nutrition.goal))
      resultArray.append(.weight(user.nutrition.weight))
      resultArray.append(.dailyCaloricNeeds(user.nutrition.dailyCaloricNeeds))
      resultArray.append(.protein(user.nutrition.protein))
      resultArray.append(.carbs(user.nutrition.carbs))
      resultArray.append(.fat(user.nutrition.fat))
      resultArray.append(.water("\(user.nutrition.waterMin) Lt - \(user.nutrition.waterMax) Lt"))

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
