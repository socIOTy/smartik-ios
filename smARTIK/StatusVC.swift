//
//  StatusVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-03-22.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit

class StatusVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()

        
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

}
