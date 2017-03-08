//
//  ViewController.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-02-04.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3
import CircleSlider
import AVFoundation

class LightBulbVC: UIViewController {
    
    @IBOutlet weak var switcher: UIButton!
    
    @IBOutlet weak var rColorSlider: UISlider!
    @IBOutlet weak var gColorSlider: UISlider!
    @IBOutlet weak var bColorSlider: UISlider!
    
    
    @IBOutlet weak var rColorLabel: UILabel!
    @IBOutlet weak var gColorLabel: UILabel!
    @IBOutlet weak var bColorLabel: UILabel!
    

    
    @IBOutlet weak var circleSlider: UIView!
    
    private var valueLabel: UILabel!
    
    private var circleAdapter: CircleSlider!
    
    private var sliderOptions: [CircleSliderOption] {
        return [
            CircleSliderOption.barColor(UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.5)),
            CircleSliderOption.thumbColor(UIColor(red: 141/255, green: 185/255, blue: 204/255, alpha: 1)),
            CircleSliderOption.trackingColor(UIColor(red: 78/255, green: 136/255, blue: 185/255, alpha: 1)),
            CircleSliderOption.barWidth(10),
            CircleSliderOption.startAngle(135),
            CircleSliderOption.maxValue(99),
            CircleSliderOption.minValue(0),
            CircleSliderOption.viewInset(1)
        ]
    }

    
    private var _device: Device!
    
    var device : Device {
        get {
            return _device
        }
        set {
            _device = newValue
        }
    }
    
    let bulbOn = UIImage(named: "bulb-on")
    let bulbOff = UIImage(named: "bulb-off")
    
    let soundPath = Bundle.main.path(forResource: "switch-sound", ofType: "wav")
    var switchSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage()
        
        
        self.buildCircleSlider()
        
        let rColor = Int(round(rColorSlider.value))
        let gColor = Int(round(gColorSlider.value))
        let bColor = Int(round(bColorSlider.value))
        
        
        rColorLabel.text = "R: \(rColor)"
        gColorLabel.text = "G: \(gColor)"
        bColorLabel.text = "B: \(bColor)"
        
        valueLabel.textColor = UIColor.lightGray
        
        let soundURL = URL(fileURLWithPath: self.soundPath!)
        
        do {
            try switchSound = AVAudioPlayer(contentsOf: soundURL)
            switchSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        self.navigationItem.title = device.name
    }
    
    override func viewDidLayoutSubviews() {
        self.circleAdapter.frame = self.circleSlider.bounds
        self.valueLabel.center = CGPoint(x: self.circleSlider.bounds.width * 0.5, y: self.circleSlider.bounds.height * 0.5)
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
        actions.ddid = device.id
        
        
        MessagesAPI.sendActions(data: actions).then {
            response -> Void in
            }.catch{error -> Void in
                print(String(format: "%s", String(describing: error)))
        }
        
    }
    
    
    @IBAction func switchPressed(_ sender: UIButton) {
        playSwitchSound()
        let actions: Actions = Actions()
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        if !(sender.tag == 1) {
            sender.tag = 1
            action.name = "setOn"
            setOn()
        } else {
            sender.tag = 0
            action.name = "setOff"
            setOff()
        }
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
    
    
    
    @IBAction func rColorChanging(_ sender: UISlider) {
        rColorLabel.text = "R: \(Int(round(rColorSlider.value)))"
        let newColor = UIColor(red: CGFloat(rColorSlider.value/255), green: CGFloat(gColorSlider.value/255), blue: CGFloat(bColorSlider.value/255), alpha: CGFloat(circleAdapter.value/100))
        self.circleAdapter.changeOptions([.trackingColor(newColor)])
    }
    
    
    @IBAction func gColorChanging(_ sender: UISlider) {
        gColorLabel.text = "G: \(Int(round(gColorSlider.value)))"
        let newColor = UIColor(red: CGFloat(rColorSlider.value/255), green: CGFloat(gColorSlider.value/255), blue: CGFloat(bColorSlider.value/255), alpha: CGFloat(circleAdapter.value/100))
        self.circleAdapter.changeOptions([.trackingColor(newColor)])
    }
    
    @IBAction func bColorChanging(_ sender: UISlider) {
        bColorLabel.text = "B: \(Int(round(bColorSlider.value)))"
        let newColor = UIColor(red: CGFloat(rColorSlider.value/255), green: CGFloat(gColorSlider.value/255), blue: CGFloat(bColorSlider.value/255), alpha: CGFloat(circleAdapter.value/100))
        self.circleAdapter.changeOptions([.trackingColor(newColor)])
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
            "intensity": Int(round(circleAdapter.value))
        ]
        
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
    
    func setOff() {
        self.circleSlider.isHidden = true
        
        self.rColorLabel.isHidden = true
        self.gColorLabel.isHidden = true
        self.bColorLabel.isHidden = true
        
        self.rColorSlider.isHidden = true
        self.gColorSlider.isHidden = true
        self.bColorSlider.isHidden = true

        
        switcher.setImage(bulbOff, for: .normal)
    }
    
    func setOn() {
        self.circleSlider.isHidden = false
        
        self.rColorLabel.isHidden = false
        self.gColorLabel.isHidden = false
        self.bColorLabel.isHidden = false
        
        self.rColorSlider.isHidden = false
        self.gColorSlider.isHidden = false
        self.bColorSlider.isHidden = false


        switcher.setImage(bulbOn, for: .normal)
    }
    
    func valueChange(sender: CircleSlider) {
        self.valueLabel.text = "\(Int(round(sender.value)))%"
        let newColor = UIColor(red: CGFloat(rColorSlider.value/255), green: CGFloat(gColorSlider.value/255), blue: CGFloat(bColorSlider.value/255), alpha: CGFloat(sender.value/100))
        self.circleAdapter.changeOptions([.trackingColor(newColor)])
    }
    
    func valueEndChange(sender: CircleSlider) {
        let actions: Actions = Actions()
        let actionArray : ActionArray = ActionArray()
        let action = Action()
        
        action.name = "setIntensity"
        
        action.parameters = ["intensity" : Int(round(sender.value))]
        
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
    
    
    
    private func buildCircleSlider() {
        self.circleAdapter = CircleSlider(frame: self.circleSlider.bounds, options: self.sliderOptions)
        self.circleAdapter?.addTarget(self, action: #selector(valueChange(sender:)), for: .valueChanged)
        self.circleAdapter?.addTarget(self, action: #selector(valueEndChange(sender:)), for: .touchUpInside)
        self.circleSlider.addSubview(self.circleAdapter!)
        self.valueLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.valueLabel.textAlignment = .center
        self.circleAdapter.addSubview(self.valueLabel)
    }
    
    func setBackgroundImage() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "room-bg")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func playSwitchSound() {
        if switchSound.isPlaying {
            switchSound.stop()
        }
        
        switchSound.play()
    }
    
}

