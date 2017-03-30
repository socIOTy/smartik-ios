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

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.title = "Status"
    }

}
