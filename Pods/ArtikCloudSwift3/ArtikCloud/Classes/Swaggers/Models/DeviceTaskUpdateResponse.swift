//
// DeviceTaskUpdateResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/**  */
open class DeviceTaskUpdateResponse: JSONEncodable {
    /** Task status */
    open var data: TaskStatus?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["data"] = self.data?.encodeToJSON()
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}