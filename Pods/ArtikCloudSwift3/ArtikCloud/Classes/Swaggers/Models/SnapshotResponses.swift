//
// SnapshotResponses.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/**  */
open class SnapshotResponses: JSONEncodable {
    open var sdids: String?
    open var size: Int32?
    open var data: [SnapshotResponse]?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["sdids"] = self.sdids
        nillableDictionary["size"] = self.size?.encodeToJSON()
        nillableDictionary["data"] = self.data?.encodeToJSON()
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
