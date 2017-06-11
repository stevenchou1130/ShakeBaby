//
//  PersonalResultViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class PersonalResultViewController: BaseViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shakeCountLabel: UILabel!
    @IBOutlet weak var replayButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = String(Game.shakedTime)
        shakeCountLabel.text = String(Game.shakedCount)

    }

    @IBAction func replay(_ sender: Any) {

        goToPage(storyboardName: Storyboard.home, controllerName: Controller.home)
    }
}
