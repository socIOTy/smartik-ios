//
// Acknowledgement.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Acknowledgement received by a WebSocket in response to a RegisterMessage, MessageIn or ActionIn. */
open class Acknowledgement: JSONEncodable {
    /** Message ID. */
    open var mid: String?
    /** Confirmation ID. */
    open var cid: String?
    /** Message. */
    open var message: String?
    /** Code */
    open var code: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["mid"] = self.mid
        nillableDictionary["cid"] = self.cid
        nillableDictionary["message"] = self.message
        nillableDictionary["code"] = self.code
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
