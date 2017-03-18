//
//  UserDefaults+Functions.swift
//  smARTIK
//
//  Created by Serhii Pianykh on 2017-03-15.
//  Copyright © 2017 socIOTy. All rights reserved.
//

import Foundation

extension UserDefaults {
    func setToken(token: String) {
        set(token, forKey: "token")
        synchronize()
    }
    
    func setExp(exp: UInt64) {
        set(exp, forKey: "exp")
        synchronize()
    }
    
    func getToken() -> String {
        if let token = string(forKey: "token") {
           return token
        }
        return ""
    }
    
    func getExp() -> UInt64 {
        return value(forKey: "exp") as! UInt64
    }
    
    func isExpired() -> Bool {
        if let exp = value(forKey: "exp") as? UInt64 {
            if exp > UInt64(NSDate().timeIntervalSince1970) {
                return false
            }
        }
        return true
    }
    
    func clearToken() {
        removeObject(forKey: "token")
        removeObject(forKey: "exp")
        synchronize()
    }
}