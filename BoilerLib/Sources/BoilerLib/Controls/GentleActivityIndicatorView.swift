//
//  GentleActivityIndicatorView.swift
//  veladan
//
//  Created by Daniel Vela Angulo on 19/02/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import UIKit

/**
 This class is an specialization of UIActivityIndicatorView used to show a waiting view.
 The base class show the control when the process starts and removes it when the process
 stops. This behavior sometimes produces some 'flicking' that is annoying.
 To prevent this behavior, this class only shows the wating view after some minimal time;
 and, once the view is showed, it's removed only after a minimal time showing it.

 This class was inspired by https://github.com/Alamofire/AlamofireNetworkActivityIndicator
*/
class GentleActivityIndicatorView: UIActivityIndicatorView {
    var startDelay: TimeInterval = 0.2
    var completionMinInterval: TimeInterval = 0.8

    private var stopAnimatingCalled: Bool = false
    private var completionMinIntervalDone: Bool = false

    override func startAnimating() {
        stopAnimatingCalled = false
        perform(#selector(startAnimatingCalled), with: nil, afterDelay: startDelay)
    }

    override func stopAnimating() {
        stopAnimatingCalled = true
        checkDoneState()
    }

  override init(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.large) {
        super.init(style: style)
    }

    /**
        Create a new object and add to the center of a parent view as a subview.
    */
    convenience init(parentView: UIView) {
        self.init()
        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ])
        parentView.bringSubviewToFront(self)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc
    private func startAnimatingCalled() {
        if stopAnimatingCalled == false {
            super.startAnimating()
            completionMinIntervalDone = false
            perform(#selector(completionMinIntervalCompleted), with: nil, afterDelay: completionMinInterval)
        }
    }

    @objc
    private func completionMinIntervalCompleted() {
        completionMinIntervalDone = true
        checkDoneState()
    }

    private func checkDoneState() {
        if completionMinIntervalDone && stopAnimatingCalled {
            super.stopAnimating()
            completionMinIntervalDone = false
            stopAnimatingCalled = false
        }
    }
}
