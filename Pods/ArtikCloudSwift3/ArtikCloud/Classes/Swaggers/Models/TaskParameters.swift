//
// TaskParameters.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/**  */
open class TaskParameters: JSONEncodable {
    /** Expire time in seconds */
    open var expiresAfter: Int32?
    /** Value to write */
    open var value: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["expiresAfter"] = self.expiresAfter?.encodeToJSON()
        nillableDictionary["value"] = self.value
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
