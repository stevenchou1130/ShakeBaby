//
//  LoadingIndicator.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/11.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class LoadingIndicator {

    var activityData: ActivityData?

    init() {
        activityData = ActivityData()
    }

    func start() {
        if activityData == nil {
            activityData = ActivityData()
        }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData!)
    }

    func stop() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
