//
//  ListVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-02-26.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var deviceList = [Device]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        UsersAPI.getUserDevices(userId: "92b683fa99164650b7907f855acc100b").then { result -> Void in
            let devices = result.data?.devices
            for device in devices! {
                self.deviceList.append(device)
            }
            self.tableView.reloadData()
            }.catch { error -> Void in
                
                print(String(format: "%s", String(describing: error)))
        }
        
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

}
