//
//  HomeViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import SCLAlertView

class HomeViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var singleGameButton: UIButton!
    @IBOutlet weak var multipleGameButton: UIButton!
    @IBOutlet weak var introduceGameButton: UIButton!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "HomeBack")
        self.view.insertSubview(backgroundImage, at: 0)

    }

    @IBAction func startSingleGame(_ sender: Any) {
        print("startSingleGame")

        Game.isSingleGame = true

        goToPage(storyboardName: Storyboard.shaking,
                 controllerName: Controller.shaking)
    }

    @IBAction func startMultipleGame(_ sender: Any) {
        print("startMultipleGame")

        Game.isSingleGame = false

        goToPage(storyboardName: Storyboard.connection,
                 controllerName: Controller.connection)
    }

    @IBAction func introduceGame(_ sender: Any) {
        print("introduceGame")

        let gameInfo = "1. Select single or multiple mode.\n\n2. Waiting for other players.\n(If you choose single mode, please ignore this step)\n\n3. Shake!!"

        SCLAlertView().showTitle("How to play",
                                 subTitle: gameInfo,
                                 style: .info)
    }
}
