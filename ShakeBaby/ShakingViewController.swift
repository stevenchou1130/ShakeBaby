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
import UIView_Shake

class ShakingViewController: BaseViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var shakeCountLabel: UILabel!
    @IBOutlet weak var bottleImageView: UIImageView!

    let motionManager = CMMotionManager()
    var timer: Timer?
    var totalTime = 3
    var shakeCount = 0
    let deviceID = "\(UIDevice.current.identifierForVendor!.uuidString)"

    override func viewDidLoad() {
        super.viewDidLoad()

        shakeCountLabel.text = "\(shakeCount)"
        timerLabel.text = "\(totalTime)"
        startTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            
            if let myData = data {
                
                if (myData.acceleration.y > 1 || myData.acceleration.y < -1) && self.totalTime > 0{
                    
                    print("Enter")
                    self.shakeCount += 1
                    self.shakeCountLabel.text = "\(self.shakeCount)"
                    self.shakeImage()
                }
                
            }
        }
    }

    func shakeImage() {

        bottleImageView.shake(  10,                 // 10 times
                                withDelta: 15.0,    // 5 points wide
                                speed: 0.03,        // 30ms per shake
                                shakeDirection: ShakeDirection.vertical
        )

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
        //print(userName.replacingOccurrences(of: " ", with: "_"))
        let formateduserName = userName.replaceCharacters(characters: " ?&/'.", toSeparator: "_")
        let urlString = "https://wuduhren.com/fap/list.php?score=\(score)&name=\(formateduserName)"

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
    
    func replaceCharacters(characters: String, toSeparator: String) -> String {
        let characterSet = CharacterSet(charactersIn: characters)
        let components = self.components(separatedBy: characterSet)
        
        let result = components.joined(separator: "")
        return result
    }
    
    func wipeCharacters(characters: String) -> String {
        return self.replaceCharacters(characters: characters, toSeparator: "")
    }
}
