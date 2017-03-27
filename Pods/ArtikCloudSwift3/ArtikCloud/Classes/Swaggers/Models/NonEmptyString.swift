//
// NonEmptyString.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/**  */
open class NonEmptyString: JSONEncodable {
    open var text: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["text"] = self.text
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
