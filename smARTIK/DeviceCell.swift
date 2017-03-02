//
//  DeviceCell.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-03-02.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import ArtikCloudSwift3

class DeviceCell: UITableViewCell {

    
    @IBOutlet weak var deviceName: UILabel!
    
    func configureCell(device: Device) {
        deviceName.text = device.name
    }

}
