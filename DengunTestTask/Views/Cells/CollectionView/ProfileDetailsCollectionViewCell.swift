//
//  ProfileDetailsCollectionViewCell.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import RxSwift

final class ProfileDetailsCollectionViewCell: UICollectionViewCell {

  private let detailsTableView = UITableView()
  private var layoutDone = false
  private var disposeBag = DisposeBag()

  override func layoutSubviews() {
    super.layoutSubviews()

    guard !layoutDone else {
      return
    }

    contentView.addSubview(detailsTableView)
    detailsTableView.register(InfoItemTableViewCell.self, forCellReuseIdentifier: "InfoItemTableViewCell")
    detailsTableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    detailsTableView.backgroundColor = .clear
    detailsTableView.separatorStyle = .none
    detailsTableView.rowHeight = 40
    detailsTableView.allowsSelection = false
    detailsTableView.showsVerticalScrollIndicator = false
    contentView.backgroundColor = .clear
    backgroundColor = .clear
    layoutDone = true
  }

  func configureWith(_ viewModel: ProfileDetailsCollectionViewCellViewModelProtocol) {
    switch viewModel.type {
    case .profileDetails:
      if let viewModel = viewModel as? ProfileDetailsCollectionViewCellViewModel {
        viewModel.profileItemsObservable
          .asDriver(onErrorJustReturn: [])
          .drive(detailsTableView.rx.items) { tableView, row, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoItemTableViewCell") as! InfoItemTableViewCell
            cell.configureWith(model)
            return cell
          }.disposed(by: disposeBag)
      } else {
        fatalError()
      }
    case .nutrition:
      if let viewModel = viewModel as? NutritionCollectionViewCellViewModel {
        viewModel.nutritionItemsObservable
          .asDriver(onErrorJustReturn: [])
          .drive(detailsTableView.rx.items) { tableView, row, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoItemTableViewCell") as! InfoItemTableViewCell
            cell.configureWith(model)
            return cell
        }.disposed(by: disposeBag)
      } else {
        fatalError()
      }
    default:
      break
    }
  }

  override func prepareForReuse() {
    disposeBag = DisposeBag()
  }
}
