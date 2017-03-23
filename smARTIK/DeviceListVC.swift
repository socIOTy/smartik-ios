//
//  ListVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-02-26.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3

class DeviceListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var deviceList = [Device]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setBackgroundImage()

        tableView.delegate = self
        tableView.dataSource = self
        
        UsersAPI.getUserDevices(userId: "92b683fa99164650b7907f855acc100b").then { result -> Void in
            let devices = result.data?.devices
            for device in devices! {
                self.deviceList.append(device)
            }
            self.animateTable()
            }.catch { error -> Void in
                
                print(String(format: "%s", String(describing: error)))
        }
        self.tabBarController?.navigationItem.title = "Device List"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
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
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: DeviceCell = a as! DeviceCell
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
    


}
