//
//  ProfileHeaderView.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 11.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProfileHeaderView: UIView {

  let userpicTap = PublishSubject<UITapGestureRecognizer>()
  let usernameLabel = UILabel()
  let userTitleLabel = UILabel()
  private let userpicImageView = UIImageView()
  private let backgroundImageView = UIImageView()
  private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
  private let contentStackView = UIStackView()
  private let disposeBag = DisposeBag()
  var userpic = UIImage() {
    didSet {
      userpicImageView.image = userpic
      backgroundImageView.image = userpic
    }
  }

  init() {
    super.init(frame: .zero)
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    addSubview(blurView)
    addSubview(backgroundImageView)
    sendSubview(toBack: backgroundImageView)
    [blurView, backgroundImageView].forEach { $0.snp.makeConstraints({ (make) in
      make.edges.equalToSuperview()
    })}
    blurView.contentView.addSubview(contentStackView)
    contentStackView.axis = .vertical
    contentStackView.spacing = 10
    contentStackView.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
    [userpicImageView, usernameLabel, userTitleLabel].forEach { contentStackView.addArrangedSubview($0) }
    configureImageViews()
    configureLabels()
  }

  private func configureImageViews() {
    [userpicImageView, backgroundImageView].forEach {
      $0.clipsToBounds = true
      $0.contentMode = .scaleAspectFill
    }
    userpicImageView.layer.borderColor = UIColor.white.cgColor
    userpicImageView.layer.borderWidth = 3
    userpicImageView.snp.makeConstraints { (make) in
      make.height.equalTo(80)
      make.width.equalTo(80)
    }
    userpicImageView.isUserInteractionEnabled = true

    let tapGesture = UITapGestureRecognizer()
    userpicImageView.addGestureRecognizer(tapGesture)

    tapGesture.rx.event
      .subscribe(userpicTap)
      .disposed(by: disposeBag)
  }

  private func configureLabels() {
    [usernameLabel, userTitleLabel].forEach {
      $0.textColor = .white
      $0.textAlignment = .center
    }
    usernameLabel.font = UIFont.boldSystemFont(ofSize: 14)
    userTitleLabel.font = UIFont.systemFont(ofSize: 12)
  }
}
