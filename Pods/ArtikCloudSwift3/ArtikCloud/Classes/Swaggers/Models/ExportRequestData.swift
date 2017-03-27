//
// ExportRequestData.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Export Request Data. */
open class ExportRequestData: JSONEncodable {
    /** Add header to csv format */
    open var csvHeaders: Bool?
    /** Timestamp of latest message (in milliseconds since epoch). */
    open var endDate: Int64?
    /** Returned Export ID that should be used to check status and get the export result. */
    open var exportId: String?
    /** Format of the export. */
    open var format: String?
    /** Ascending or descending sort order. */
    open var order: String?
    /** Source Device IDs being searched for messages (Comma-separated for multiple Device IDs). */
    open var sdids: String?
    /** Source Device Type IDs being searched for messages (Comma-separated for multiple Device Type IDs). */
    open var sdtids: String?
    /** Timestamp of earliest message (in milliseconds since epoch). */
    open var startDate: Int64?
    /** Trial ID being searched for messages. */
    open var trialId: String?
    /** Owner&#39;s user IDs being searched for messages (Comma-separated for multiple User IDs). */
    open var uids: String?
    /** URL added to successful email message. */
    open var url: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["csvHeaders"] = self.csvHeaders 
        nillableDictionary["endDate"] = self.endDate?.encodeToJSON()
        nillableDictionary["exportId"] = self.exportId 
        nillableDictionary["format"] = self.format 
        nillableDictionary["order"] = self.order 
        nillableDictionary["sdids"] = self.sdids 
        nillableDictionary["sdtids"] = self.sdtids 
        nillableDictionary["startDate"] = self.startDate?.encodeToJSON()
        nillableDictionary["trialId"] = self.trialId 
        nillableDictionary["uids"] = self.uids 
        nillableDictionary["url"] = self.url 
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
