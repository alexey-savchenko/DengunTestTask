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

  lazy var searchLabel: UILabel = {
    let label = UILabel()
    label.text = "Search other Goliaz athletes here"
    label.textColor = UIColor.lightText.withAlphaComponent(0.4)
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()

  lazy var lensImage: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "lens"))
    imageView.snp.makeConstraints({ (make) in
      make.height.equalTo(30)
    })
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let searchStack = UIStackView()

  override func layoutSubviews() {
    super.layoutSubviews()

    guard !layoutDone else {
      return
    }

    contentView.addSubview(searchStack)
    searchStack.axis = .horizontal
    searchStack.distribution = .equalSpacing
    searchStack.alignment = .center
    searchStack.snp.makeConstraints { (make) in
      make.height.equalTo(50)
      make.leading.equalToSuperview().offset(50)
      make.trailing.equalToSuperview().offset(20)
      make.top.equalToSuperview()
    }
    [searchLabel, lensImage].forEach { searchStack.addArrangedSubview($0) }

    contentView.addSubview(followersTableView)
    followersTableView.register(FollowerTableViewCell.self, forCellReuseIdentifier: "FollowerTableViewCell")
    followersTableView.snp.makeConstraints { (make) in
      make.top.equalTo(searchStack.snp.bottom)
      make.leading.equalToSuperview()
      make.bottom.equalToSuperview()
      make.trailing.equalToSuperview()
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
