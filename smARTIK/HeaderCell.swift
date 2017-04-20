//
//  HeaderCell.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-19.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var sectionName: UILabel!
    
    func configureCell(number: Int) {
        sectionName.text = "Floor \(number)"
    }

}
