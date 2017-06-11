//
//  ConnectionViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol runTimerDelegate: class {
    func runTimer()
}

class ConnectionViewController: BaseViewController {

    @IBOutlet weak var readyTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    var timer: Timer?

    var readyTimer: Timer?
    var totalTime = 3

    let deviceID = "\(UIDevice.current.identifierForVendor!.uuidString)"

    let loadingIndicator = LoadingIndicator()

    //在這個controller做loading畫面
    //NVActivityIndicatorView
    //loading結束後跑倒數畫面

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Waiting for other players"
        readyTimeLabel.isHidden = true

        loadingIndicator.start()

        postID()
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
        readyTimer?.invalidate()
    }

    func postID() {

        guard let url = URL(string: "https://wuduhren.com/fap/register.php?id=\(deviceID)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = deviceID.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard data != nil else { return }
            print(data!)
        }

        task.resume()
    }

    func readyConfirm() {

        let urlString = URL(string:"https://wuduhren.com/fap/start.php")

        guard let url = urlString else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data else { return }

            guard let stringData = String(data: data, encoding: .utf8) else { return }

            let intData = Int(stringData)

            print(intData!)

            if  intData == 1 {

                self.stopTimer()
                print(self.timer ?? "no timer")

                DispatchQueue.main.async {
                    self.loadingIndicator.stop()
                    self.startReadyTimer()
                }
            }

        }

        task.resume()
    }
    
    func startTimer() {
        
        if timer == nil {
             timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(readyConfirm),
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

    func startReadyTimer() {

        titleLabel.text = "Ready"
        readyTimeLabel.isHidden = false

        if readyTimer == nil {
            readyTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: (#selector(updateReadyTimer)),
                                         userInfo: nil,
                                         repeats: true)
        }
    }

    func updateReadyTimer() {

        print("=== updateReadyTimer ===")

        if totalTime > 0 {
            totalTime -= 1
            readyTimeLabel.text = "\(totalTime)"
        }


        if totalTime <= 0 {
            stopReadyTimer()
            self.goToPage(storyboardName: Storyboard.shaking,
                          controllerName: Controller.shaking)
        }
    }

    func stopReadyTimer() {

        if readyTimer != nil {
            readyTimer?.invalidate()
            readyTimer = nil
        }
    }
}
