//
//  ProfileDetailsTableViewCell.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

final class ProfileDetailsTableViewCell: UITableViewCell {

  private let titleLabel = UILabel()
  private let valueLabel = UILabel()
  private let contentStackView = UIStackView()
  private let bgView = UIView()
  private var layoutDone = false

  override func layoutSubviews() {
    super.layoutSubviews()

    guard !layoutDone else {
      return
    }
    setupLayout()
  }

  private func setupLayout() {
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    contentView.addSubview(bgView)
    bgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    bgView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(5)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview().offset(-5)
    }
    bgView.addSubview(contentStackView)
    contentStackView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.leading.equalToSuperview().offset(8)
      make.trailing.equalToSuperview().offset(-8)
      make.bottom.equalToSuperview()
    }
    contentStackView.axis = .horizontal
    contentStackView.alignment = .center
    contentStackView.distribution = .equalSpacing
    [titleLabel, valueLabel].forEach {
      contentStackView.addArrangedSubview($0)
      $0.textColor = .white
    }
  }

  func configureWith(_ profileInfoItem: ProfileInfoItem) {
    switch profileInfoItem {

    case .rank(let value):
      valueLabel.text = value
    case .level(let value):
      valueLabel.text = "\(value)"
    case .points(let value):
      valueLabel.text = "\(value)"
    case .workouts(let value):
      valueLabel.text = "\(value)"
    case .trainingTime(let value):
      valueLabel.text = value
    case .triningSince(let value):
      valueLabel.text = value
    case .followers(let value):
      valueLabel.text = "\(value)"
    }

    titleLabel.text = profileInfoItem.title
  }
}
