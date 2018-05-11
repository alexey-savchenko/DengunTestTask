//
//  TabIndicatorView.swift
//  DengunTestTask
//
//  Created by Alexey Savchenko on 10.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import SnapKit

class TabIndicatorView: UIView {

  // MARK: Init and deinit
  init(_ items: [String]) {
    super.init(frame: .zero)
    configure(with: items)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Properties
  private var items = [String]()
  private var itemLabels = [UILabel]()
  private var selectedItemIndex = 0 {
    didSet {
      selectedItem(at: selectedItemIndex)
    }
  }
  private var tabSelectionViewInitLayoutDone = false

  // MARK: UI
  private let contentStackView = UIStackView()
  private let tabSelectionMarkerView = UIView()

  // MARK: Functions
  private func configure(with items: [String]) {
    self.items = items
    itemLabels = items.enumerated().map { idx, item in
      let label = UILabel()
      label.text = item
      label.font = UIFont.systemFont(ofSize: 14)
      label.textColor = .white
      label.textAlignment = .center
      label.backgroundColor = .clear
      label.isUserInteractionEnabled = true
      label.tag = idx

      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemLabelTap))
      label.addGestureRecognizer(tapGesture)

      return label
    }

    configureStackView()
    setupSelectionView()
    backgroundColor = UIColor.darkGray
    selectedItemIndex = 0
  }

  private func configureStackView() {
    addSubview(contentStackView)
    contentStackView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    contentStackView.axis = .horizontal
    contentStackView.distribution = .fillEqually
    itemLabels.forEach { contentStackView.addArrangedSubview($0) }
  }

  private func setupSelectionView() {
    addSubview(tabSelectionMarkerView)
    tabSelectionMarkerView.snp.makeConstraints { (make) in
      make.edges.equalTo(itemLabels.first!.snp.edges)
    }
    sendSubview(toBack: tabSelectionMarkerView)
    tabSelectionMarkerView.layer.backgroundColor = UIColor(hexString: "189e02").cgColor
    tabSelectionMarkerView.layer.setAffineTransform(shearTransform(x: 0.5, y: 0))
  }

  private func shearTransform(x: CGFloat, y: CGFloat) -> CGAffineTransform {
    var transform = CGAffineTransform(scaleX: 1.1, y: 1)
    transform.c = -x
    transform.b = y
    return transform
  }

   @objc private func itemLabelTap(_ tapGesture: UITapGestureRecognizer) {
    if let view = tapGesture.view {
      selectedItemIndex = view.tag
    }
  }

  private func selectedItem(at index: Int) {
    UIView.animate(withDuration: 0.2) {
      self.tabSelectionMarkerView.center = self.itemLabels[index].center
    }

  }
}
