//
//  FollowerTableViewCell.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import SDWebImage

class FollowerTableViewCell: UITableViewCell {

  private let nameLabel = UILabel()
  private let userpic = UIImageView()
  private let locationLabel = UILabel()

  private let cellBackgroundView = UIView()
  private let innerStackView = UIStackView()

  private var layoutDone = false

  override func layoutSubviews() {
    super.layoutSubviews()

    guard !layoutDone else {
      return
    }
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    setupBackgroundView()
    setupUserpic()
    setupInnerStackView()
    setupLabels()
  }

  private func setupLabels() {
    [nameLabel, locationLabel].forEach {
      $0.textColor = UIColor.white
    }

    nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
    locationLabel.font = UIFont.systemFont(ofSize: 14)
  }

  private func setupUserpic() {
    userpic.layer.borderColor = UIColor.white.cgColor
    userpic.layer.borderWidth = 1
    userpic.clipsToBounds = true
    userpic.layer.cornerRadius = 20
    cellBackgroundView.addSubview(userpic)
    userpic.snp.makeConstraints { (make) in
      make.height.equalTo(40)
      make.width.equalTo(40)
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(16)
    }
  }

  private func setupBackgroundView() {
    contentView.addSubview(cellBackgroundView)
    cellBackgroundView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview().offset(16)
      make.top.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    cellBackgroundView.layer.borderWidth = 1
    cellBackgroundView.layer.borderColor = UIColor.white.cgColor

    let dotView = UIView()
    dotView.backgroundColor = .white
    dotView.clipsToBounds = true
    dotView.layer.cornerRadius = 4
    cellBackgroundView.addSubview(dotView)
    dotView.snp.makeConstraints { (make) in
      make.width.equalTo(8)
      make.height.equalTo(8)
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(-4)
    }
  }

  private func setupInnerStackView() {
    cellBackgroundView.addSubview(innerStackView)
    innerStackView.snp.makeConstraints { (make) in
      make.leading.equalTo(userpic.snp.trailing).offset(20)
      make.top.equalToSuperview().offset(10)
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview().offset(-10)
    }
    innerStackView.axis = .vertical
    innerStackView.distribution = .fillEqually
    [nameLabel, locationLabel].forEach { innerStackView.addArrangedSubview($0) }
  }

  func configureWith(_ item: FollowerTableViewCellViewModelType) {
    nameLabel.text = item.name
    locationLabel.text = item.locationString
    userpic.sd_setImage(with: item.userpicURL)
  }
}
