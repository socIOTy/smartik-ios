//
// DeviceToken.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Device Token */
open class DeviceToken: JSONEncodable {
    open var accessToken: String?
    open var uid: String?
    open var did: String?
    open var cid: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["accessToken"] = self.accessToken 
        nillableDictionary["uid"] = self.uid 
        nillableDictionary["did"] = self.did 
        nillableDictionary["cid"] = self.cid 
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
