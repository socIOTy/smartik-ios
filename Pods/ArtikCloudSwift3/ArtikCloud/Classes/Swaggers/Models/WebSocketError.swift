//
// WebSocketError.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** WebSocket Error Information */
open class WebSocketError: JSONEncodable {
    /** Message. */
    open var message: String?
    /** Code */
    open var code: Int32?
    /** Confirmation ID */
    open var cid: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["message"] = self.message 
        nillableDictionary["code"] = self.code?.encodeToJSON()
        nillableDictionary["cid"] = self.cid 
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
