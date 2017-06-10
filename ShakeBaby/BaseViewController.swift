//
//  BaseViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var previousStoryboardName = Constant.Storyboard.HOME
    var previousControllerName = Constant.Controller.HOME

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func goToPage(storyboardName: String, controllerName: String) {

        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: controllerName)
        self.present(controller, animated: true, completion: nil)

        self.previousStoryboardName = storyboardName
        self.previousControllerName = controllerName
    }

    func backToPreviousPage() {

        let storyboard = UIStoryboard(name: self.previousStoryboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: self.previousControllerName)
        self.present(controller, animated: true, completion: nil)

    }
}
