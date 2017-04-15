//
//  ListVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-02-26.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3
import Alamofire

class DeviceListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var deviceList = [Device]()
    
    private var userId: String!
    
    private var devicesTypesData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setBackgroundImage()

        tableView.delegate = self
        tableView.dataSource = self
        
        for i in Metadata.devicesTypesWithNames {
            devicesTypesData.append(i.key)
        }
        
        UsersAPI.getSelf().then { result -> Void in
            UserDefaults.standard.setUserId(id: (result.data?.id)!)
            self.getDeviceList(userId: (result.data?.id)!)
            }.catch { error -> Void in
                print(String(format: "%s", String(describing: error)))
        }
        
    }
    
    func getDeviceList(userId : String) {
        UsersAPI.getUserDevices(userId: userId).then { result -> Void in
            let devices = result.data?.devices
            self.deviceList.removeAll()
            for device in devices! {
                self.deviceList.append(device)
            }
            self.animateTable()
            }.catch { error -> Void in
                
                print(String(format: "%s", String(describing: error)))
        }

    }
    
    func addPressed() {
        print("yay")
        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let margin:CGFloat = 20.0
        let firstItem = CGRect(x: margin, y: margin, width: alertController.view.bounds.size.width - margin * 2.0, height: 30)
        let deviceName = UITextField(frame: firstItem)
        deviceName.placeholder = "Device Name"
        alertController.view.addSubview(deviceName)
        
        let secondItem = CGRect(x: margin, y: 2.0 * margin + 30, width: alertController.view.bounds.size.width - margin * 4.0, height: 80)
        let deviceType = UIPickerView(frame: secondItem)
        deviceType.dataSource = self
        deviceType.delegate = self
        
        
        alertController.view.addSubview(deviceType)
        
        let somethingAction = UIAlertAction(title: "Add Device", style: .default, handler: {(alert: UIAlertAction!) in
            print("something")
            print(self.devicesTypesData[deviceType.selectedRow(inComponent: 0)])
            print(deviceName.text!)
            print(UserDefaults.standard.getUserId())
            let dtid = Metadata.devicesTypesWithNames[self.devicesTypesData[deviceType.selectedRow(inComponent: 0)]]
            let name = deviceName.text!
            self.addDevice(name: name, dtid: dtid!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:{})
        }
    }
    
    func addDevice(name: String, dtid: String){
        let device = Device()
        device.name = name
        device.uid = UserDefaults.standard.getUserId()
        device.dtid = dtid
        DevicesAPI.addDevice(device: device).then { result in
            self.addDeviceREST(id:(result.data?.id!)!, floor: 0, room: "Living room")
        }.catch { error -> Void in
            print(String(format: "%s", String(describing: error)))
        }

    }
    
    func addDeviceREST(id: String, floor: Int, room: String) {
        let params : [String:Any] = [
            "deviceId":id,
            "floorNumber":floor,
            "roomName":room
        ]
        Alamofire.request(Metadata.devicesRestURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { response in
            print(response)
        })
        self.getDeviceList(userId: UserDefaults.standard.getUserId())
    }
    
    func deleteDevice(index: Int) {
        let id = deviceList[index].id!
        DevicesAPI.deleteDevice(deviceId: id).then { Void in
            self.deleteDeviceREST(id: id)
            }.catch { error -> Void in
                print(String(format: "%s", String(describing: error)))
        }

    }
    
    func deleteDeviceREST(id: String) {
        let params : [String:Any] = [
            "deviceId":id
        ]
        Alamofire.request(Metadata.devicesRestURL, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: nil).response(completionHandler: { response in
            print(response)
        })
        self.getDeviceList(userId: UserDefaults.standard.getUserId())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
        let addDevice = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        
        self.tabBarController?.navigationItem.rightBarButtonItem = addDevice
        
        self.tabBarController?.navigationItem.title = "Device List"
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as? DeviceCell {
            let device = deviceList[indexPath.row]
            cell.configureCell(device: device)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDevice(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = deviceList[indexPath.row]
        performSegue(withIdentifier: Metadata.deviceTypes[device.dtid!]!, sender: device)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LightBulbVC {
            if let device = sender as? Device {
                destination.device = device
            }
        }
        if let destination = segue.destination as? ThermostatVC {
            if let device = sender as? Device {
                destination.device = device
            }
        }
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for i in cells {
            let cell: DeviceCell = i as! DeviceCell
            UIView.animate(withDuration: 1.5, delay: 0.05*Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            index += 1
        }
    }
    
    func setBackgroundImage() {
        UIGraphicsBeginImageContext(self.tableView.frame.size)
        UIImage(named: "list-bg")?.draw(in: self.tableView.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.tableView.backgroundColor = UIColor(patternImage: image)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return devicesTypesData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devicesTypesData[row]
    }
}
