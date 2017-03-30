//
// TasksStatusCounts.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/**  */
open class TasksStatusCounts: JSONEncodable {
    /** Cancelled */
    open var CANCELLED: Int32?
    /** Complete */
    open var COMPLETE: Int32?
    /** Processing */
    open var PROCESSING: Int32?
    /** Requested */
    open var REQUESTED: Int32?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["CANCELLED"] = self.CANCELLED?.encodeToJSON()
        nillableDictionary["COMPLETE"] = self.COMPLETE?.encodeToJSON()
        nillableDictionary["PROCESSING"] = self.PROCESSING?.encodeToJSON()
        nillableDictionary["REQUESTED"] = self.REQUESTED?.encodeToJSON()
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}