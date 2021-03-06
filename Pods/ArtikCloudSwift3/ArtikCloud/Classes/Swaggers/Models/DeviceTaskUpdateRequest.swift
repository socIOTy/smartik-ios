//
// DeviceTaskUpdateRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/**  */
open class DeviceTaskUpdateRequest: JSONEncodable {
    /** Status */
    open var status: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["status"] = self.status
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
