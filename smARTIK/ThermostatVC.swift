//
//  ThermostatVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-03-03.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3

class ThermostatVC: UIViewController {
    
    
    @IBOutlet weak var temperatureSegment: UISegmentedControl!
    @IBOutlet weak var stateSegment: UISegmentedControl!
    
    
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    
    var currentTemp: Double = 20
    var currentDegree: Character = "C"
    
    
    @IBOutlet weak var tempSlider: UISlider!
    
    private var _device: Device!
    
    var device : Device {
        get {
            return _device
        }
        set {
            _device = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage()
        self.navigationItem.title = device.name

        tempSetup(temp: currentTemp, degree: currentDegree)
        
    }
    
    
    
    @IBAction func degreeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            currentDegree = "C"
            fToC()
        } else {
            currentDegree = "F"
            cToF()
        }
        sendTemp()
    }

    
    @IBAction func tempChanged(_ sender: UISlider) {
        currentTemp = Double(sender.value).rounded()
        sendTemp()
        tempSetup(temp: currentTemp, degree: currentDegree)
    }
    
    
    @IBAction func stateChanged(_ sender: UISegmentedControl) {
        var state = ""
        switch sender.selectedSegmentIndex {
        case 0: state = "setOff"
                break
        case 1: state = "setHeatCoolMode"
                break
        case 2: state = "setHeatMode"
                break
        case 3: state = "setCoolMode"
                break
        default: break
        }
        
        sendThermostatState(state: state)
    }
    
    func setCelsius() {
        tempSlider.minimumValue = 10;
        tempSlider.maximumValue = 40;
        minTempLbl.text = "10°C"
        maxTempLbl.text = "40°C"
    }

    func setFahrenheit() {
        tempSlider.minimumValue = 50;
        tempSlider.maximumValue = 104;
        minTempLbl.text = "50°F"
        maxTempLbl.text = "104°F"
    }
    
    func tempSetup(temp: Double, degree: Character) {
        currentTempLbl.text = "\(temp.rounded().clean)°\(degree)"
        currentTemp = temp
        currentDegree = degree
        if (temperatureSegment.selectedSegmentIndex == 0) {
            setCelsius()
        } else {
            setFahrenheit()
        }
        tempSlider.setValue(Float(temp), animated: true)
    }
    
    func sendTemp() {
        let actions: Actions = Actions()
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        
        if (currentDegree == "C") {
            action.name = "setTemperature"
        } else {
            action.name = "setTemperatureInFahrenheit"
        }
        
        action.parameters = ["temp" : currentTemp]
        
        actionArray.actions = []
        actionArray.actions!.append(action)
        actions.data = actionArray
        actions.ddid = device.id
        
        MessagesAPI.sendActions(data: actions).then {
            response -> Void in
            }.catch{error -> Void in
                print(String(format: "%s", String(describing: error)))
        }
    }
    
    func sendThermostatState(state: String) {
        let actions: Actions = Actions()
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        action.name = state
        
        actionArray.actions = []
        actionArray.actions!.append(action)
        actions.data = actionArray
        actions.ddid = device.id
        
        
        MessagesAPI.sendActions(data: actions).then {
            response -> Void in
            }.catch{error -> Void in
                print(String(format: "%s", String(describing: error)))
        }

    }
    
    func cToF() {
        currentTemp = currentTemp * 1.8 + 32
        tempSetup(temp: currentTemp, degree: currentDegree)
    }
    
    func fToC() {
        currentTemp = (currentTemp - 32) / 1.8
        tempSetup(temp: currentTemp, degree: currentDegree)
    }
    
    func setBackgroundImage() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "room-bg")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    }

}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
