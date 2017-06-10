//
//  ConnectionViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

protocol runTimerDelegate: class {
    func runTimer()
}

class ConnectionViewController: UIViewController {
    let deviceID = "\(UIDevice.current.identifierForVendor!.uuidString)"
    weak var delegate: runTimerDelegate?
    //在這個controller做loading畫面
    //NVActivityIndicatorView
    //loading結束後跑倒數畫面
    //imageView change <number picture>
    override func viewDidLoad() {
        super.viewDidLoad()
        postID()

        // Do any additional setup after loading the view.

        sendRequestToSever()
    }

    func postID() {

        guard let url = URL(string: "https://wuduhren.com/fap/register.php?id=\(deviceID)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = deviceID.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

        }

        task.resume()
        print("=== postID ===")
    }

    func sendRequestToSever() {

        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(readyConfirm), userInfo: nil, repeats: true)

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

            print(intData)

            if  intData == 1 {
                self.delegate?.runTimer()

                DispatchQueue.main.async {
                    self.view.backgroundColor = .red
                }
            }

        }

        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
