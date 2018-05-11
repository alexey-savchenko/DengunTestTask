//
//  ViewController.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 08.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

final class UserHomeController: UIViewController {

  // MARK: Init and deinit
  init(_ viewModel: UserHomeControllerViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: UI
  private let headerView = ProfileHeaderView()
  
  lazy var tabIndicatorView: TabIndicatorView = {
    return TabIndicatorView(viewModel.tabItems)
  }()

  // MARK: Properties
  private let viewModel: UserHomeControllerViewModelType

  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.darkGray
    configureUI()
  }

  // MARK: Functions
  private func configureUI() {
    setupNavigationBarItems()
    setupHeader()
  }

  private func setupNavigationBarItems() {
    navigationItem.leftBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .plain, target: nil, action: nil)]
    navigationItem.rightBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: nil, action: nil)]
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.barStyle = .black
  }

  private func setupHeader() {
    setupTabIndicator()

    view.addSubview(headerView)
    headerView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview()
      make.top.equalTo(tabIndicatorView.snp.bottom)
      make.trailing.equalToSuperview()
      make.height.equalTo(200)
    }
    headerView.usernameLabel.text = "Test"
    headerView.userTitleLabel.text = "Test"
    headerView.userpic = #imageLiteral(resourceName: "settings")
  }

  private func setupTabIndicator() {
    view.addSubview(tabIndicatorView)
    tabIndicatorView.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.height.equalTo(28)
    }
  }
}
