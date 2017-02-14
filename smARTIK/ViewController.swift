//
//  ViewController.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-02-04.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3

class ViewController: UIViewController {
    
    @IBOutlet weak var statulLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        Authentification.artikCloudLogin()
    }
    
    @IBAction func switched(_ sender: UISwitch) {
        let actions: Actions = Actions()
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        if sender.isOn {
            action.name = "setOn"
        } else {
            action.name = "setOff"
        }
        
        actionArray.actions = []
        actionArray.actions!.append(action)
        actions.data = actionArray
        actions.ddid = Metadata.deviceID
        
        MessagesAPI.sendActions(data: actions).then {
            response -> Void in
            self.statulLbl.text = response.data?.mid!
            }.catch{error -> Void in
                print(String(format: "%s", String(describing: error)))
        }
        
    }
}

