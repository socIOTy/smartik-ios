//
// Device.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Device information. */
open class Device: JSONEncodable {
    /** Device ID */
    open var id: String?
    /** User ID */
    open var uid: String?
    /** Device Type ID */
    open var dtid: String?
    /** Name */
    open var name: String?
    /** Manifest Version */
    open var manifestVersion: Int32?
    /** Manifest Version Policy (LATEST, DEVICE) */
    open var manifestVersionPolicy: String?
    /** Needs Provider Authentication */
    open var needProviderAuth: Bool?
    /** Status of Cloud Authorization */
    open var cloudAuthorization: String?
    open var properties: [String:Any]?
    /** Created On (milliseconds since epoch) */
    open var createdOn: Int64?
    /** Is Connected */
    open var connected: Bool?
    /** Certificate Info (if any) */
    open var certificateInfo: String?
    /** Certificate Signature (if any) */
    open var certificateSignature: String?
    /** External ID (if any) */
    open var eid: String?
    open var providerCredentials: [String:Any]?
    open var deviceTypeName: String?
    
    
    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["id"] = self.id 
        nillableDictionary["uid"] = self.uid 
        nillableDictionary["dtid"] = self.dtid 
        nillableDictionary["name"] = self.name 
        nillableDictionary["manifestVersion"] = self.manifestVersion?.encodeToJSON()
        nillableDictionary["manifestVersionPolicy"] = self.manifestVersionPolicy 
        nillableDictionary["needProviderAuth"] = self.needProviderAuth 
        nillableDictionary["cloudAuthorization"] = self.cloudAuthorization 
        nillableDictionary["properties"] = self.properties?.encodeToJSON()
        nillableDictionary["createdOn"] = self.createdOn?.encodeToJSON()
        nillableDictionary["connected"] = self.connected 
        nillableDictionary["certificateInfo"] = self.certificateInfo 
        nillableDictionary["certificateSignature"] = self.certificateSignature 
        nillableDictionary["eid"] = self.eid 
        nillableDictionary["providerCredentials"] = self.providerCredentials?.encodeToJSON()
        nillableDictionary["deviceTypeName"] = self.deviceTypeName 
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func isCloudAuthorized() -> Bool {
        if let cloudAuthorization = cloudAuthorization {
            if cloudAuthorization == "UNAUTHORIZED" {
                return false
            }
        }
        return true
    }
}
