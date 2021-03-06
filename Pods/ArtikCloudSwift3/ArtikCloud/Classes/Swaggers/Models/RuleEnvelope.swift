//
// RuleEnvelope.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Rule Envelope. */
open class RuleEnvelope: JSONEncodable {
    open var data: OutputRule?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["data"] = self.data?.encodeToJSON()
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
