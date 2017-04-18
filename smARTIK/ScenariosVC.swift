//
//  ScenariosVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-03-22.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit

class ScenariosVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var scenarios = [Scenario]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        scenarios.append(Scenario(name: "Turn off the lights", action: .lightOff))
        scenarios.append(Scenario(name: "Turn on the lights", action: .lightOn))
        scenarios.append(Scenario(name: "Energy saving mode", action: .energySaving))
        scenarios.append(Scenario(name: "Mode \"Home\"", action: .stateHome))
        scenarios.append(Scenario(name: "Mode \"Away\"", action: .stateAway))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.title = "Scenario List"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scenarios.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScenarioCell", for: indexPath) as? ScenarioCell {
            cell.configureCell(scenario: scenarios[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

}
