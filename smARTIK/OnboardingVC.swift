//
//  OnboardingVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-04-16.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingVC: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onboarding = PaperOnboarding(itemsCount: 4)
        onboarding.dataSource = self
        onboarding.delegate = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        let skipButton = UIButton()
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(UIColor.white, for: .normal)
        skipButton.addTarget(self, action: #selector(self.skipPresseed(_:)), for: .touchUpInside)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skipButton)

        //add constraints
        for attribute: NSLayoutAttribute in [.right] {
            let constraint = NSLayoutConstraint(item: skipButton, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: -30)
            view.addConstraint(constraint)
        }
        
        for attribute: NSLayoutAttribute in [.bottom] {
            let constraint = NSLayoutConstraint(item: skipButton, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: -80)
            view.addConstraint(constraint)
        }

        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if UserDefaults.standard.isOnboardingCompleted() {
            performSegue(withIdentifier: "LoginVC", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
        let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
        return [
            ("LOGO_GREY", "Welcome", "To work with our app you need to create a Samsung ARTIK Cloud account first", "key-icon", UIColor(red:0.71, green:0.71, blue:0.71, alpha:1.00), UIColor.white, UIColor.white, titleFont, descriptionFont),
            ("rooms-img", "Rooms", "Set up rooms and control all devices assigned", "key-icon", UIColor(red:0.40, green:0.56, blue:0.71, alpha:1.00), UIColor.white, UIColor.white, titleFont, descriptionFont),
            ("devices-img", "Devices", "Monitor and control all your devices from the app", "electrisity-icon", UIColor(red:0.40, green:0.69, blue:0.71, alpha:1.00), UIColor.white, UIColor.white, titleFont, descriptionFont),
            ("scenarios-img", "Scenarios", "Design and Apply scenarios to control action flow of your smart devices", "pen-icon", UIColor(red:0.61, green:0.56, blue:0.74, alpha:1.00), UIColor.white, UIColor.white, titleFont, descriptionFont)
            ][index]
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        //skipButton.isHidden = index == 3 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func skipPresseed(_ sender: UIButton!) {
        UserDefaults.standard.setOnboardingCompleted()
        performSegue(withIdentifier: "LoginVC", sender: self)
    }

}
