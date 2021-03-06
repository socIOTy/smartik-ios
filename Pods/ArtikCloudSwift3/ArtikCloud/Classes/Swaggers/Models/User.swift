//
// User.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** User Information */
open class User: NSObject, NSCoding, JSONEncodable {
    open var id: String?
    open var name: String?
    open var email: String?
    open var fullName: String?
    open var saIdentity: String?
    open var createdOn: Int64?
    open var modifiedOn: Int64?

    struct PropertyKey {
        static let id_key = "_id"
        static let name_key = "_name"
        static let email_key = "_email"
        static let fullName_key = "_fullName"
        static let saIdentity = "_saIdentity"
        static let createdOn = "_createdOn"
        static let modifiedOn = "_modifiedOn"
    }
    
    public override init() {
        super.init()
    }
    
    init(id: String?, name: String?, email: String?, fullname: String?, saIdentity: String?, createdOn: Int64?, modifiedOn: Int64?) {
        super.init()
        self.id = id
        self.name = name
        self.email = email
        self.fullName = fullname
        self.saIdentity = saIdentity
        self.createdOn = createdOn
        self.modifiedOn = modifiedOn
    }

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["id"] = self.id 
        nillableDictionary["name"] = self.name 
        nillableDictionary["email"] = self.email 
        nillableDictionary["fullName"] = self.fullName 
        nillableDictionary["saIdentity"] = self.saIdentity 
        nillableDictionary["createdOn"] = self.createdOn?.encodeToJSON()
        nillableDictionary["modifiedOn"] = self.modifiedOn?.encodeToJSON()
        let dictionary = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id_key)
        aCoder.encode(name, forKey: PropertyKey.name_key)
        aCoder.encode(email, forKey: PropertyKey.email_key)
        aCoder.encode(fullName, forKey: PropertyKey.fullName_key)
        aCoder.encode(saIdentity, forKey: PropertyKey.saIdentity)
        if let createdOn = createdOn {
            aCoder.encode(createdOn, forKey: PropertyKey.createdOn)
        }
        if let modifiedOn = modifiedOn {
            aCoder.encode(modifiedOn, forKey: PropertyKey.modifiedOn)
        }
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: PropertyKey.id_key) as? String
        let name = aDecoder.decodeObject(forKey: PropertyKey.name_key) as? String
        let email = aDecoder.decodeObject(forKey: PropertyKey.email_key) as? String
        let fullName = aDecoder.decodeObject(forKey: PropertyKey.fullName_key) as? String
        let saIdentity = aDecoder.decodeObject(forKey: PropertyKey.saIdentity) as? String
        
        var createdOn: Int64?
        if aDecoder.containsValue(forKey: PropertyKey.createdOn) {
            createdOn = aDecoder.decodeInt64(forKey: PropertyKey.createdOn)
        }
        
        var modifiedOn: Int64?
        if aDecoder.containsValue(forKey: PropertyKey.modifiedOn) {
            modifiedOn = aDecoder.decodeInt64(forKey: PropertyKey.modifiedOn)
        }
        
        self.init(id: id, name: name, email: email, fullname: fullName, saIdentity: saIdentity, createdOn: createdOn, modifiedOn: modifiedOn)
    }
}
