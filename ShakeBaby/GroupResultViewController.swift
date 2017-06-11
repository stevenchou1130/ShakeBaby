//
//  GroupResultViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class GroupResultViewController: UIViewController, UITableViewDataSource, UIWebViewDelegate {
    
    @IBOutlet weak var scorechart: UITableView!
    
    var scoreArray: [[String: String]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResult()
        
        let nib = UINib(nibName: "GroupResultTableViewCell", bundle: nil)
        
        scorechart.register(nib, forCellReuseIdentifier: "GroupResultTableViewCell")
        
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
            guard let stringData = String(data: data, encoding: .utf8) else { return }
            
            let resultArray = stringData.components(separatedBy: ",")
            
            var arrayOfString: [[String]] = []

            var resultDict: [String: String] = [:]
            
            for i in resultArray {
                let array = i.components(separatedBy: ":")
                
                arrayOfString.append(array)
            }
            
            self.scoreArray = []
            
            for scoreObject in arrayOfString {
                let key = scoreObject[0]
                let value = scoreObject[1]
                
                resultDict["name"] = key
                resultDict["score"] = value
                
                self.scoreArray.append(resultDict)
            }
            
//            print(arrayOfString)
//            print("================")
//            print(resultDict)
//            print("================")
//            print(self.scoreArray)
            
            self.scoreArray.sort { Int($0["score"]!)! < Int($1["score"]!)! }
            print(self.scoreArray)

            
            DispatchQueue.main.async {
                self.scorechart.reloadData()
            }
        }
        
        task.resume()
    }
    
    func Ranking() {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = scorechart.dequeueReusableCell(withIdentifier: "GroupResultTableViewCell", for: indexPath) as? GroupResultTableViewCell {
        
            
                
            
            cell.rank.text = String(indexPath.row + 1)
            cell.userName.text = scoreArray[indexPath.row]["name"]
            cell.shakeCount.text = scoreArray[indexPath.row]["score"]
            
            
        return cell
        }
        return UITableViewCell()
    }

}
