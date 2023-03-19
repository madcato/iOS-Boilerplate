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
        self.view.addSubview(activityView)
    }

    func hideActivityView() {
        for view in self.view.subviews where view is UIActivityIndicatorView {
            view.removeFromSuperview()
        }
    }
}
