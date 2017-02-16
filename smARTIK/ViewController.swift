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
    
    
    @IBOutlet weak var intensitySlider: UISlider!
    @IBOutlet weak var rColorSlider: UISlider!
    @IBOutlet weak var gColorSlider: UISlider!
    @IBOutlet weak var bColorSlider: UISlider!
    
    
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var rColorLabel: UILabel!
    @IBOutlet weak var gColorLabel: UILabel!
    @IBOutlet weak var bColorLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let intensityLevel = Int(round(intensitySlider.value))
        let rColor = Int(round(rColorSlider.value))
        let gColor = Int(round(gColorSlider.value))
        let bColor = Int(round(bColorSlider.value))
        
        intensityLabel.text = "Intensity: \(intensityLevel)"
        
        rColorLabel.text = "R: \(rColor)"
        gColorLabel.text = "G: \(gColor)"
        bColorLabel.text = "B: \(bColor)"
        
        colorView.backgroundColor = UIColor(red: CGFloat(rColor/255), green: CGFloat(gColor/255), blue: CGFloat(bColor/255), alpha: CGFloat(intensityLevel/100))
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
    
    
    @IBAction func intensityChanging(_ sender: UISlider) {
        intensityLabel.text = "Intensity: \(Int(round(intensitySlider.value)))"
        colorView.backgroundColor = UIColor(red: CGFloat(rColorSlider.value/255), green: CGFloat(gColorSlider.value/255), blue: CGFloat(bColorSlider.value/255), alpha: CGFloat(intensitySlider.value/100))
    }
    
    
    @IBAction func rColorChanging(_ sender: UISlider) {
        rColorLabel.text = "R: \(Int(round(rColorSlider.value)))"
        colorView.backgroundColor = UIColor(red: CGFloat(rColorSlider.value/255), green: CGFloat(gColorSlider.value/255), blue: CGFloat(bColorSlider.value/255), alpha: CGFloat(intensitySlider.value/100))
    }
    
    
    @IBAction func gColorChanging(_ sender: UISlider) {
        gColorLabel.text = "G: \(Int(round(gColorSlider.value)))"
        colorView.backgroundColor = UIColor(red: CGFloat(rColorSlider.value/255), green: CGFloat(gColorSlider.value/255), blue: CGFloat(bColorSlider.value/255), alpha: CGFloat(intensitySlider.value/100))
    }
    
    @IBAction func bColorChanging(_ sender: UISlider) {
        bColorLabel.text = "B: \(Int(round(bColorSlider.value)))"
        colorView.backgroundColor = UIColor(red: CGFloat(rColorSlider.value/255), green: CGFloat(gColorSlider.value/255), blue: CGFloat(bColorSlider.value/255), alpha: CGFloat(intensitySlider.value/100))
    }
    
    
    @IBAction func colorChangingEnds(_ sender: UISlider) {
        let actions: Actions = Actions()
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        
        action.name = "setColorAsRGB"
        
        let bulbColorRGB: [String:Int] = [
            "r":Int(round(rColorSlider.value)),
            "g":Int(round(gColorSlider.value)),
            "b":Int(round(bColorSlider.value))
        ]
        
        action.parameters = [
            "colorRGB": bulbColorRGB,
            "intensity": Int(round(intensitySlider.value))
        ]
        
        actionArray.actions = []
        actionArray.actions!.append(action)
        actions.data = actionArray
        actions.ddid = Metadata.deviceID
        
        MessagesAPI.sendActions(data: actions).then {
            response -> Void in
            //self.statulLbl.text = response.data?.mid!
            }.catch{error -> Void in
                print(String(format: "%s", String(describing: error)))
        }

    }
    
    @IBAction func intensityChangingEnds(_ sender: UISlider) {
        let actions: Actions = Actions()
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        
        action.name = "setIntensity"
    
        action.parameters = ["intensity" : Int(round(intensitySlider.value))]
        
        actionArray.actions = []
        actionArray.actions!.append(action)
        actions.data = actionArray
        actions.ddid = Metadata.deviceID
        
        MessagesAPI.sendActions(data: actions).then {
            response -> Void in
            //self.statulLbl.text = response.data?.mid!
            }.catch{error -> Void in
                print(String(format: "%s", String(describing: error)))
        }
    }
    
    
}

