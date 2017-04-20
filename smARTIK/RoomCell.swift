//
//  RoomCell.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-19.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit

class RoomCell: UITableViewCell {

    
    @IBOutlet weak var roomName: UILabel!
    
    func configureCell(name: String) {
        roomName.text = name
    }

}
