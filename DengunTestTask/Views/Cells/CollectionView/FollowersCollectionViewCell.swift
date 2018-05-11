//
//  FollowersCollectionViewCell.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import RxSwift

class FollowersCollectionViewCell: UICollectionViewCell {

  private let followersTableView = UITableView()
  private var layoutDone = false
  private var disposeBag = DisposeBag()

  override func layoutSubviews() {
    super.layoutSubviews()

    guard !layoutDone else {
      return
    }

    contentView.addSubview(followersTableView)
    followersTableView.register(FollowerTableViewCell.self, forCellReuseIdentifier: "FollowerTableViewCell")
    followersTableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    followersTableView.backgroundColor = .clear
    followersTableView.separatorStyle = .none
    followersTableView.rowHeight = 60
    followersTableView.allowsSelection = false
    followersTableView.showsVerticalScrollIndicator = false
    contentView.backgroundColor = .clear
    backgroundColor = .clear
    layoutDone = true
  }

  func configureWith(_ viewModel: ProfileDetailsCollectionViewCellViewModelProtocol) {
    if let viewModel = viewModel as? FollowersCollectionViewCellViewModel {

      viewModel.followersItemsObservable
        .asDriver(onErrorJustReturn: [])
        .drive(followersTableView.rx.items) { tableView, row, model in

          let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell") as! FollowerTableViewCell
          cell.configureWith(model)
          return cell

      }.disposed(by: disposeBag)

    } else {
      fatalError()
    }
  }

}
