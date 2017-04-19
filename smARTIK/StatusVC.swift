//
//  StatusVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-03-22.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3

class StatusVC: UIViewController {

    @IBOutlet weak var greetingLabel: UITextField!
    @IBOutlet weak var devicesLabel: UILabel!
    
    var fullname: String = ""
    var deviceCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        
        getStatus()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.title = "Status"
    }
    
    func setBackgroundImage() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background-gen")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func getStatus() {
        UsersAPI.getSelf().then { result -> Void in
            self.fullname = (result.data?.fullName!)!
            self.getDevices()
            }.catch { error -> Void in
                print(String(format: "%s", String(describing: error)))
        }

    }
    
    func getDevices() {
        UsersAPI.getUserDevices(userId: UserDefaults.standard.getUserId()).then { result -> Void in
            self.deviceCount = (result.data?.devices?.count)!
            self.updateUI()
            }.catch { error -> Void in
                print(String(format: "%s", String(describing: error)))
        }
    }
    
    func updateUI() {
        greetingLabel.text = "Welcome home, \(fullname)!"
        devicesLabel.text = "You have \(deviceCount)/\(deviceCount) active devices"
    }

}
