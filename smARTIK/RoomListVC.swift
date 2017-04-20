//
//  RoomListVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-03-22.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import Alamofire

class RoomListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var deviceMap: DeviceMap = DeviceMap()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getMap()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.title = "Room List"
    }
    
    func setBackgroundImage() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background-gen")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (deviceMap.floors[section].count()) >= 0 {
            return (deviceMap.floors[section].count())
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (deviceMap.floors.count) >= 0 {
            return (deviceMap.floors.count)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Floor \(section+1)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as? RoomCell {
            cell.configureCell(name: deviceMap.floors[indexPath.section].rooms[indexPath.row].name)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func getMap() {
        var header = HTTPHeaders()
        header = ["Authorization":"Basic \(UserDefaults.standard.getEmail().base64Encoded()!)"]
        Alamofire.request(Metadata.deviceMapURL+UserDefaults.standard.getEmail(), method: .get, parameters: [:], encoding: URLEncoding.default, headers: header).responseJSON(completionHandler: { result in
            if let data = result.result.value as? Dictionary<String, Any> {
                print(data["deviceMap"])
                self.deviceMap = DeviceMap(data: (data["deviceMap"] as? Dictionary<String, Any>)!)
                self.tableView.reloadData()
            }
            
        })
    }
    

}


extension String {
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
