//
//  ShakingViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox


class ShakingViewController: BaseViewController {
    @IBOutlet weak var timerLabel: UILabel!


    //@IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var shakeCountLabel: UILabel!

    let motionManager = CMMotionManager()
    var timer: Timer?
    var totalTime = 3
    var shakeCount = 0
    let deviceID = "\(UIDevice.current.identifierForVendor!.uuidString)"

    override func viewDidLoad() {
        super.viewDidLoad()

        
        timerLabel.text = "\(totalTime)"
        startTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            
            if let myData = data {
                
                if myData.acceleration.y > 5 || myData.acceleration.y < -5 && self.totalTime > 0{
                    
                    print("Enter")
                    self.shakeCount += 1
                    self.shakeCountLabel.text = "\(self.shakeCount)"
                }
                
            }
        }
    }
    
    func startTimer() {
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: (#selector(updateTimer)),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    func stopTimer() {
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
    }



    func updateTimer() {

        print("=== updateTimer ===")

        if totalTime > 0 {
            totalTime -= 1
            timerLabel.text = "\(totalTime)"
        }

        if totalTime <= 0 {
            stopTimer()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            postResults()
        }

    }
    
    func postResults() {

        guard let score = shakeCountLabel.text else { return }

        let userName = UIDevice.current.name
        
        //let characterArray: [Character] = [" ", "?", "\", "&"]
        //userName.stringByRemovingAll(characters: characterArray)
        let urlString = "https://wuduhren.com/fap/list.php?score=\(score)&name=\(userName)"
        print(deviceID)
        
        print(score)
        print(userName)
        print(urlString)
        guard
            let url = URL(string: urlString)
            else {
                print("wrong url")
                return
            }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        //request.httpBody = deviceID.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
        }

        task.resume()
        print("postResult")

    }
    
}

extension String {
    func stringByRemovingAll(characters: [Character]) -> String {
        return String(self.characters.filter({ !characters.contains($0) }))
    }
    
}
