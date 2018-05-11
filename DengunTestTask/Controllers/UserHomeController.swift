//
//  ViewController.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 08.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
  lazy var profileDetailsCollectionView: UICollectionView = {

    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.delegate = self
    collectionView.isPagingEnabled = true
    collectionView.bounces = false
    collectionView.backgroundColor = .clear

    return collectionView
  }()

  lazy var tabIndicatorView: TabIndicatorView = {
    return TabIndicatorView(viewModel.tabItems)
  }()

  // MARK: Properties
  private let viewModel: UserHomeControllerViewModelType
  private let disposeBag = DisposeBag()

  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    setupBindings()
  }

  // MARK: Functions
  private func configureUI() {
    view.backgroundColor = UIColor.darkGray
    setupNavigationBarItems()
    setupHeader()
    setupProfileDetailsCollectionView()
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

    headerView.userpicTap.subscribe(onNext: { [unowned self] _ in
      let prompt = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)

      prompt.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { (_) in
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.showsCameraControls = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
      }))

      prompt.addAction(UIAlertAction(title: "Choose a picture", style: .default, handler: { (_) in
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
      }))

      prompt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      self.present(prompt, animated: true, completion: nil)
    }).disposed(by: disposeBag)

  }

  func setupBindings() {
    viewModel.profileImage
      .subscribe(headerView.userpicSubject)
      .disposed(by: disposeBag)

    viewModel.currentUserData.subscribe(onNext: { [unowned headerView = headerView] user in
      headerView.userTitleLabel.text = user.bio
      headerView.usernameLabel.text = user.fullName
      }, onError: { [unowned self] error in
        self.presentError(error.localizedDescription)
        self.headerView.userTitleLabel.text = "Unknown"
        self.headerView.usernameLabel.text = "Unknown"
    }).disposed(by: disposeBag)

    viewModel.profileItemsData
      .asDriver(onErrorJustReturn: [])
      .drive(profileDetailsCollectionView.rx.items) { collectionView, row, model in

        switch model.type {
        case .profileDetails:
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileDetailsCollectionViewCell",
                                                        for: IndexPath(row: row, section: 0)) as! ProfileDetailsCollectionViewCell
          cell.configureWith(model)
          return cell
        case .followers:
          fatalError()
        case .nutrition:
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileDetailsCollectionViewCell",
                                                        for: IndexPath(row: row, section: 0)) as! ProfileDetailsCollectionViewCell
          cell.configureWith(model)
          return cell
        }

    }.disposed(by: disposeBag)
  }

  private func setupTabIndicator() {
    view.addSubview(tabIndicatorView)
    tabIndicatorView.delegate = self
    tabIndicatorView.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.height.equalTo(28)
    }
  }

  private func setupProfileDetailsCollectionView() {
    view.addSubview(profileDetailsCollectionView)
    profileDetailsCollectionView.snp.makeConstraints { (make) in
      make.top.equalTo(headerView.snp.bottom)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    profileDetailsCollectionView.register(ProfileDetailsCollectionViewCell.self,
                                          forCellWithReuseIdentifier: "ProfileDetailsCollectionViewCell")
  }
}

extension UserHomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      viewModel.userpicSelected.onNext(pickedImage)
      picker.dismiss(animated: true, completion: nil)
    }
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}

extension UserHomeController: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentPage = pageIndexFor(contentOffset: scrollView.contentOffset)
    tabIndicatorView.setItemSelected(Int(currentPage))
  }
  private func pageIndexFor(contentOffset offset: CGPoint) -> Float {
    return roundf(Float(offset.x / UIScreen.main.bounds.width))
  }
}

extension UserHomeController: TabIndicatorViewDelegate {
  func itemSelected(at index: Int) {
    profileDetailsCollectionView.setContentOffset(CGPoint(x: CGFloat(index) * profileDetailsCollectionView.bounds.width, y: 0),
                                                  animated: true)
  }
}
