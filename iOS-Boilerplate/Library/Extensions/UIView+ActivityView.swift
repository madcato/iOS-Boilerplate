//
//  UIView+ActivityView.swift
//  lishop-swift-uikit
//
//  Created by Daniel Vela on 19/3/23.
//

import UIKit

protocol ActivityViewProtocol {
    func showActivityView()
    func hideActivityView()
}

extension ActivityViewProtocol where Self: UIViewController {
func showActivityView() {
  let activityView = UIActivityIndicatorView(style: .large)
  activityView.color = .black
  activityView.center = self.view.center
  activityView.startAnimating()
  activityView.tag = 345
  self.view.addSubview(activityView)
}

  func hideActivityView() {
    for view in self.view.subviews where view is UIActivityIndicatorView {
      if view.tag == 345 {
        view.removeFromSuperview()
      }
    }
  }
}

protocol ActivityProtocol {
    func showActivityView()
    func hideActivityView()
}

extension ActivityProtocol where Self: UIView {
func showActivityView() {
  let activityView = UIActivityIndicatorView(style: .medium)
  activityView.color = .black
  activityView.center = self.center
  activityView.startAnimating()
  activityView.tag = 345
  activityView.layer.zPosition = 1000
  self.addSubview(activityView)
}

  func hideActivityView() {
    for view in self.subviews where view is UIActivityIndicatorView {
      if view.tag == 345 {
        view.removeFromSuperview()
      }
    }
  }
}

extension UIView: ActivityProtocol {
}
