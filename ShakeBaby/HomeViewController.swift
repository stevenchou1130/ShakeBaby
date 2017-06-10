//
//  HomeViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var singleGameButton: UIButton!
    @IBOutlet weak var multipleGameButton: UIButton!
    @IBOutlet weak var introduceGameButton: UIButton!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func startSingleGame(_ sender: Any) {
        print("startSingleGame")

    }

    @IBAction func startMultipleGame(_ sender: Any) {
        print("startMultipleGame")
    }

    @IBAction func introduceGame(_ sender: Any) {
        print("introduceGame")
    }
}
