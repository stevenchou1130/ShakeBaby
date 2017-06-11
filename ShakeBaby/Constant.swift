//
//  Constant.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation

struct Storyboard {

    static let home             = "Home"
    static let shaking          = "Shaking"
    static let connection       = "Connection"
    static let personalResult   = "PersonalResult"
    static let groupResult      = "GroupResult"

}

struct Controller {

    static let home             = "HomeViewController"
    static let shaking          = "ShakingViewController"
    static let connection       = "ConnectionViewController"
    static let personalResult   = "PersonalResultViewController"
    static let groupResult      = "GroupResultViewController"

}

struct Game {

    static var isSingleGame     = false
    static var shakedTime       = 0
    static var shakedCount      = 0
    
}
