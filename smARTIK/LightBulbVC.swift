//
//  ViewController.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-02-04.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3

class LightBulbVC: UIViewController {
    
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
    
    
    @IBOutlet weak var colorTitle: UILabel!
    @IBOutlet weak var rColorTitle: UILabel!
    @IBOutlet weak var gColorTitle: UILabel!
    @IBOutlet weak var bColorTitle: UILabel!
    
    @IBOutlet weak var switchBulb: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (switchBulb.isOn) {
            setOn()
        } else {
            setOff()
        }
        
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
            setOn()
        } else {
            action.name = "setOff"
            setOff()
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
    
    func setOff() {
        self.statulLbl.isHidden = true
        
        self.intensityLabel.isHidden = true
        self.rColorLabel.isHidden = true
        self.gColorLabel.isHidden = true
        self.bColorLabel.isHidden = true
        
        self.intensitySlider.isHidden = true
        self.rColorSlider.isHidden = true
        self.gColorSlider.isHidden = true
        self.bColorSlider.isHidden = true
        
        self.colorView.isHidden = true
        
        self.colorTitle.isHidden = true
        self.rColorTitle.isHidden = true
        self.gColorTitle.isHidden = true
        self.bColorTitle.isHidden = true
    }
    
    func setOn() {
        self.statulLbl.isHidden = false
        
        self.intensityLabel.isHidden = false
        self.rColorLabel.isHidden = false
        self.gColorLabel.isHidden = false
        self.bColorLabel.isHidden = false
        
        self.intensitySlider.isHidden = false
        self.rColorSlider.isHidden = false
        self.gColorSlider.isHidden = false
        self.bColorSlider.isHidden = false
        
        self.colorView.isHidden = false
        
        self.colorTitle.isHidden = false
        self.rColorTitle.isHidden = false
        self.gColorTitle.isHidden = false
        self.bColorTitle.isHidden = false

    }
    
    
}

