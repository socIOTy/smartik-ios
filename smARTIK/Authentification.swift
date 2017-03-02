//
//  Authentification.swift
//  LightBulb
//
//  Created by Serhii Pianykh on 2017-02-08.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import Foundation
import UIKit

class Authentification {
    
    static let authPath: String = "https://accounts.artik.cloud/authorize?" +
        "client_id=\(Metadata.appClientID)&" +
        "response_type=token&" +
        "redirect_uri=\(Metadata.appRedirectURI)&" +
    "state=\(Metadata.appState)"
    
    static func artikCloudLogin() {
        
        UIApplication.shared.open((URL(string: authPath)!), options: [:], completionHandler: nil)
        
    }
    
    static var credentials: [String: String] = [:]
    
}

