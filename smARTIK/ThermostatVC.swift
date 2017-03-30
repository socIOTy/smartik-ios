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
    var state: String = "setOff"
    
    
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
        
        onGetMessage()
        
    }
    
    
    
    @IBAction func degreeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            currentDegree = "C"
            UserDefaults.standard.setDegree(degree: 0)
            fToC()
        } else {
            currentDegree = "F"
            UserDefaults.standard.setDegree(degree: 1)
            cToF()
        }
        sendTemp()
    }

    
    @IBAction func tempChanged(_ sender: UISlider) {
        currentTemp = Double(sender.value).rounded()
        tempSetup(temp: currentTemp, degree: currentDegree)
    }
    
    
    @IBAction func tempChangeFinished(_ sender: UISlider) {
        sendTemp()
    }
    
    
    @IBAction func stateChanged(_ sender: UISegmentedControl) {
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
        UIImage(named: "bedroom")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func onGetMessage() {
        
        
        let sdid = device.id
        
        //ARTIK Cloud MessagesAPI for sending / receiving message
        
        MessagesAPI.getLastNormalizedMessages(sdids: sdid).then { response -> Void in
            
            let normalizedMessage = response.data! as [NormalizedMessage]
            
            // move along if no messages
            if normalizedMessage.isEmpty == true {
                
                print("No messages")
                return
                
            }
            
            let responseObject:[String:String] = [
                "mid": String(describing: normalizedMessage[0].mid!),
                "ts": String(describing: normalizedMessage[0].ts!),
                "sdtid": String(describing: normalizedMessage[0].sdtid!),
                "data": String(describing: normalizedMessage[0].data!)
            ]
            print(responseObject["data"]!)
            let data = normalizedMessage[0].data!
            
            self.currentTemp = Double(data["target_temperature_c"] as! Int)
            let heat = data["can_heat"] as! Bool
            let cool = data["can_cool"] as! Bool
            if heat && cool {
                self.state = "setHeatCoolMode"
            } else {
                if heat {
                    self.state = "setHeatMode"
                } else if cool {
                    self.state = "setCoolMode"
                } else {
                    self.state = "setOff"
                }
            }
            
            if (UserDefaults.standard.getDegree() == 0) {
                self.currentDegree = "C"
                self.temperatureSegment.selectedSegmentIndex = 0
            } else if (UserDefaults.standard.getDegree() == 1) {
                self.currentDegree = "F"
                self.cToF()
                self.temperatureSegment.selectedSegmentIndex = 1
            }
            
            self.initUI()
            
            //print(responseObject.description)
            
            }.catch { error -> Void in
                
                print(String(format: "%s", String(describing: error)))
                print("Get Message Error: " + String(describing: error))
        }
        
    }
    
    func setThermostatState() {
        switch(state) {
            case "setOff":
                stateSegment.selectedSegmentIndex = 0
                break
            case "setHeatCoolMode":
                stateSegment.selectedSegmentIndex = 1
                break
            case "setHeatMode":
                stateSegment.selectedSegmentIndex = 2
                break
            case "setCoolMode":
                stateSegment.selectedSegmentIndex = 3
                break
            default:
                stateSegment.selectedSegmentIndex = 0
        }
    }

    func initUI() {
        tempSetup(temp: currentTemp, degree: currentDegree)
        setThermostatState()
    }

}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
