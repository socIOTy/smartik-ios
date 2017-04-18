//
//  ScenarioCell.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-18.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit

class ScenarioCell: UICollectionViewCell {
    
    @IBOutlet weak var scenarioImage: UIImageView!
    
    @IBOutlet weak var scenarioTitle: UILabel!
    
    func configureCell(scenario: Scenario) {
        scenarioTitle.text = scenario.name
        var imgName = ""
        switch scenario.action {
            case .lightOn:
                imgName = "light_on"
                break
            case .lightOff:
                imgName = "light_off"
                break
            case .stateHome:
                imgName = "state_home"
                break
            case .stateAway:
                imgName = "state_away"
                break
            case .energySaving:
                imgName = "energy_saving"
                break
            default:
            break
        }
        let image = UIImage(named: imgName)
        scenarioImage.image = image
    }
}
