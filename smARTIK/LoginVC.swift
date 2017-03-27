//
//  LoginVC.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-02-26.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import UIKit
import Alamofire
import ArtikCloudSwift3

class LoginVC: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var logoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        setBackgroundImage()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.getToken() != "" && !UserDefaults.standard.isExpired() {
            ArtikCloudAPI.customHeaders["Authorization"] = "bearer " + UserDefaults.standard.getToken()
            self.performSegue(withIdentifier: "DeviceListVC", sender: self)
        }
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        webView.isHidden = false
        loginBtn.isHidden = true
        logoImg.isHidden = true
        let url = URL(string: Authentification.authPath)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        //Authentification.artikCloudLogin()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let str = request.url?.absoluteString
        //print(str)
        if (str?.hasPrefix(Metadata.appRedirectURI))! {
            print("FUCK YEAH")
            webView.isHidden = true
            loginBtn.isHidden = false
            let callbackUrl = str!.replacingOccurrences(of: "#", with: "?")
            
            let urlComponents = URLComponents(url: URL(string: callbackUrl)!, resolvingAgainstBaseURL: false)
            
            if let queryParams = urlComponents?.queryItems {
                
                for param in queryParams {
                    
                    NSLog(">>params: \(param.name) = \(param.value)")
                    Authentification.credentials[param.name] = param.value
                }
                
            }
            
            
            ArtikCloudAPI.customHeaders["Authorization"] = "bearer " + Authentification.credentials["access_token"]!
            let exp: UInt64 = UInt64(Authentification.credentials["expires_in"]!)! + UInt64(NSDate().timeIntervalSince1970)
            UserDefaults.standard.setToken(token: Authentification.credentials["access_token"]!)
            UserDefaults.standard.setExp(exp: exp)
            performSegue(withIdentifier: "DeviceListVC", sender: self)
            return false
        }
        return true
    }
    
    func setBackgroundImage() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "login-screen-bg2")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    }

}
