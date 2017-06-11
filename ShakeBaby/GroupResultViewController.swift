//
//  GroupResultViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class GroupResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getResult() {
        let urlString = URL(string:"https://wuduhren.com/fap/list.php?result=1")
        guard let url = urlString else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            
            print(data)
            
          
            
        }
        
        task.resume()
    }

}
