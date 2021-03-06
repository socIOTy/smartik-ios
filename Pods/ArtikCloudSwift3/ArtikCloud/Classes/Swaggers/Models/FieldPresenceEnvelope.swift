//
// FieldPresenceEnvelope.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Field Presence Envelope */
open class FieldPresenceEnvelope: JSONEncodable {
    open var sdid: String?
    open var fieldPresence: String?
    open var startDate: Int64?
    open var endDate: Int64?
    open var interval: String?
    open var size: Int64?
    open var data: [FieldPresence]?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["sdid"] = self.sdid 
        nillableDictionary["fieldPresence"] = self.fieldPresence 
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()
        nillableDictionary["interval"] = self.interval 
        nillableDictionary["size"] = self.size?.encodeToJSON()
        nillableDictionary["data"] = self.data?.encodeToJSON()
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
