//
// UsersAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire
import PromiseKit



open class UsersAPI: APIBase {
    /**
     Create User Application Properties
     
     - parameter userId: (path) User Id 
     - parameter properties: (body) Properties to be updated 
     - parameter aid: (query) Application ID (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createUserProperties(userId: String, properties: AppProperties, aid: String? = nil, completion: @escaping ((_ data: PropertiesEnvelope?, _ error: Error?) -> Void)) {
        createUserPropertiesWithRequestBuilder(userId: userId, properties: properties, aid: aid).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Create User Application Properties
     
     - parameter userId: (path) User Id 
     - parameter properties: (body) Properties to be updated 
     - parameter aid: (query) Application ID (optional)
     - returns: Promise<PropertiesEnvelope>
     */
    open class func createUserProperties(userId: String, properties: AppProperties, aid: String? = nil) -> Promise<PropertiesEnvelope> {
        let deferred = Promise<PropertiesEnvelope>.pending()
        createUserProperties(userId: userId, properties: properties, aid: aid) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Create User Application Properties
     - POST /users/{userId}/properties
     - Create application properties for a user
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "uid" : "aeiou",
    "aid" : "aeiou",
    "properties" : "aeiou"
  }
}}]
     
     - parameter userId: (path) User Id 
     - parameter properties: (body) Properties to be updated 
     - parameter aid: (query) Application ID (optional)

     - returns: RequestBuilder<PropertiesEnvelope> 
     */
    open class func createUserPropertiesWithRequestBuilder(userId: String, properties: AppProperties, aid: String? = nil) -> RequestBuilder<PropertiesEnvelope> {
        var path = "/users/{userId}/properties"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path
        
        let parameters = properties.encodeToJSON() as? [String:Any]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<PropertiesEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Delete User Application Properties
     
     - parameter userId: (path) User Id 
     - parameter aid: (query) Application ID (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteUserProperties(userId: String, aid: String? = nil, completion: @escaping ((_ data: PropertiesEnvelope?, _ error: Error?) -> Void)) {
        deleteUserPropertiesWithRequestBuilder(userId: userId, aid: aid).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Delete User Application Properties
     
     - parameter userId: (path) User Id 
     - parameter aid: (query) Application ID (optional)
     - returns: Promise<PropertiesEnvelope>
     */
    open class func deleteUserProperties(userId: String, aid: String? = nil) -> Promise<PropertiesEnvelope> {
        let deferred = Promise<PropertiesEnvelope>.pending()
        deleteUserProperties(userId: userId, aid: aid) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Delete User Application Properties
     - DELETE /users/{userId}/properties
     - Deletes a user's application properties
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "uid" : "aeiou",
    "aid" : "aeiou",
    "properties" : "aeiou"
  }
}}]
     
     - parameter userId: (path) User Id 
     - parameter aid: (query) Application ID (optional)

     - returns: RequestBuilder<PropertiesEnvelope> 
     */
    open class func deleteUserPropertiesWithRequestBuilder(userId: String, aid: String? = nil) -> RequestBuilder<PropertiesEnvelope> {
        var path = "/users/{userId}/properties"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "aid": aid
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<PropertiesEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Get Current User Profile
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getSelf(_ completion: @escaping ((_ data: UserEnvelope?, _ error: Error?) -> Void)) {
        getSelfWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get Current User Profile
     
     - returns: Promise<UserEnvelope>
     */
    open class func getSelf() -> Promise<UserEnvelope> {
        let deferred = Promise<UserEnvelope>.pending()
        getSelf() { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Get Current User Profile
     - GET /users/self
     - Get's the current user's profile
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "saIdentity" : "aeiou",
    "modifiedOn" : 123456789,
    "name" : "aeiou",
    "fullName" : "aeiou",
    "id" : "aeiou",
    "createdOn" : 123456789,
    "email" : "aeiou"
  }
}}]

     - returns: RequestBuilder<UserEnvelope> 
     */
    open class func getSelfWithRequestBuilder() -> RequestBuilder<UserEnvelope> {
        let path = "/users/self"
        let URLString = ArtikCloudAPI.basePath + path

        let requestBuilder: RequestBuilder<UserEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: nil, isBody: true)
    }

    /**
     Get User Device Types
     
     - parameter userId: (path) User ID. 
     - parameter offset: (query) Offset for pagination. (optional)
     - parameter count: (query) Desired count of items in the result set (optional)
     - parameter includeShared: (query) Optional. Boolean (true/false) - If false, only return the user&#39;s device types. If true, also return device types shared by other users. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUserDeviceTypes(userId: String, offset: Int32? = nil, count: Int32? = nil, includeShared: Bool? = nil, completion: @escaping ((_ data: DeviceTypesEnvelope?, _ error: Error?) -> Void)) {
        getUserDeviceTypesWithRequestBuilder(userId: userId, offset: offset, count: count, includeShared: includeShared).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get User Device Types
     
     - parameter userId: (path) User ID. 
     - parameter offset: (query) Offset for pagination. (optional)
     - parameter count: (query) Desired count of items in the result set (optional)
     - parameter includeShared: (query) Optional. Boolean (true/false) - If false, only return the user&#39;s device types. If true, also return device types shared by other users. (optional)
     - returns: Promise<DeviceTypesEnvelope>
     */
    open class func getUserDeviceTypes(userId: String, offset: Int32? = nil, count: Int32? = nil, includeShared: Bool? = nil) -> Promise<DeviceTypesEnvelope> {
        let deferred = Promise<DeviceTypesEnvelope>.pending()
        getUserDeviceTypes(userId: userId, offset: offset, count: count, includeShared: includeShared) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Get User Device Types
     - GET /users/{userId}/devicetypes
     - Retrieve User's Device Types
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "total" : 123,
  "offset" : 123,
  "data" : {
    "deviceTypes" : [ {
      "hasCloudConnector" : true,
      "issuerDn" : "aeiou",
      "description" : "aeiou",
      "oid" : "aeiou",
      "published" : true,
      "rsp" : true,
      "tags" : [ {
        "isCategory" : true,
        "name" : "aeiou"
      } ],
      "vid" : "aeiou",
      "lastUpdated" : 123456789,
      "uid" : "aeiou",
      "approved" : true,
      "uniqueName" : "aeiou",
      "protected" : true,
      "latestVersion" : 123,
      "inStore" : true,
      "name" : "aeiou",
      "id" : "aeiou",
      "ownedByCurrentUser" : true
    } ]
  },
  "count" : 123
}}]
     
     - parameter userId: (path) User ID. 
     - parameter offset: (query) Offset for pagination. (optional)
     - parameter count: (query) Desired count of items in the result set (optional)
     - parameter includeShared: (query) Optional. Boolean (true/false) - If false, only return the user&#39;s device types. If true, also return device types shared by other users. (optional)

     - returns: RequestBuilder<DeviceTypesEnvelope> 
     */
    open class func getUserDeviceTypesWithRequestBuilder(userId: String, offset: Int32? = nil, count: Int32? = nil, includeShared: Bool? = nil) -> RequestBuilder<DeviceTypesEnvelope> {
        var path = "/users/{userId}/devicetypes"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "offset": offset?.encodeToJSON(),
            "count": count?.encodeToJSON(),
            "includeShared": includeShared
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<DeviceTypesEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Get User Devices
     
     - parameter userId: (path) User ID 
     - parameter offset: (query) Offset for pagination. (optional)
     - parameter count: (query) Desired count of items in the result set (optional)
     - parameter includeProperties: (query) Optional. Boolean (true/false) - If false, only return the user&#39;s device types. If true, also return device types shared by other users. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUserDevices(userId: String, offset: Int32? = nil, count: Int32? = nil, includeProperties: Bool? = nil, includeTypeNames: Bool? = nil, completion: @escaping ((_ data: DevicesEnvelope?, _ error: Error?) -> Void)) {
        getUserDevicesWithRequestBuilder(userId: userId, offset: offset, count: count, includeProperties: includeProperties, includeTypeNames: includeTypeNames).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get User Devices
     
     - parameter userId: (path) User ID 
     - parameter offset: (query) Offset for pagination. (optional)
     - parameter count: (query) Desired count of items in the result set (optional)
     - parameter includeProperties: (query) Optional. Boolean (true/false) - If false, only return the user&#39;s device types. If true, also return device types shared by other users. (optional)
     - returns: Promise<DevicesEnvelope>
     */
    open class func getUserDevices(userId: String, offset: Int32? = nil, count: Int32? = nil, includeProperties: Bool? = nil, includeTypeNames: Bool? = nil) -> Promise<DevicesEnvelope> {
        let deferred = Promise<DevicesEnvelope>.pending()
        getUserDevices(userId: userId, offset: offset, count: count, includeProperties: includeProperties, includeTypeNames: includeTypeNames) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Get User Devices
     - GET /users/{userId}/devices
     - Retrieve User's Devices
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "total" : 123,
  "offset" : 123,
  "data" : {
    "devices" : [ {
      "eid" : "aeiou",
      "dtid" : "aeiou",
      "manifestVersion" : 123,
      "certificateInfo" : "aeiou",
      "createdOn" : 123456789,
      "connected" : true,
      "uid" : "aeiou",
      "manifestVersionPolicy" : "aeiou",
      "name" : "aeiou",
      "needProviderAuth" : true,
      "certificateSignature" : "aeiou",
      "id" : "aeiou",
      "providerCredentials" : {
        "key" : "{}"
      },
      "properties" : {
        "key" : "{}"
      }
    } ]
  },
  "count" : 123
}}]
     
     - parameter userId: (path) User ID 
     - parameter offset: (query) Offset for pagination. (optional)
     - parameter count: (query) Desired count of items in the result set (optional)
     - parameter includeProperties: (query) Optional. Boolean (true/false) - If false, only return the user&#39;s device types. If true, also return device types shared by other users. (optional)

     - returns: RequestBuilder<DevicesEnvelope> 
     */
    open class func getUserDevicesWithRequestBuilder(userId: String, offset: Int32? = nil, count: Int32? = nil, includeProperties: Bool? = nil, includeTypeNames: Bool? = nil) -> RequestBuilder<DevicesEnvelope> {
        var path = "/users/{userId}/devices"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "offset": offset?.encodeToJSON(),
            "count": count?.encodeToJSON(),
            "includeProperties": includeProperties,
            "dt_name": includeTypeNames
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
        
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<DevicesEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Get User application properties
     
     - parameter userId: (path) User Id 
     - parameter aid: (query) Application ID (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUserProperties(userId: String, aid: String? = nil, completion: @escaping ((_ data: PropertiesEnvelope?, _ error: Error?) -> Void)) {
        getUserPropertiesWithRequestBuilder(userId: userId, aid: aid).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get User application properties
     
     - parameter userId: (path) User Id 
     - parameter aid: (query) Application ID (optional)
     - returns: Promise<PropertiesEnvelope>
     */
    open class func getUserProperties(userId: String, aid: String? = nil) -> Promise<PropertiesEnvelope> {
        let deferred = Promise<PropertiesEnvelope>.pending()
        getUserProperties(userId: userId, aid: aid) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Get User application properties
     - GET /users/{userId}/properties
     - Get application properties of a user
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "uid" : "aeiou",
    "aid" : "aeiou",
    "properties" : "aeiou"
  }
}}]
     
     - parameter userId: (path) User Id 
     - parameter aid: (query) Application ID (optional)

     - returns: RequestBuilder<PropertiesEnvelope> 
     */
    open class func getUserPropertiesWithRequestBuilder(userId: String, aid: String? = nil) -> RequestBuilder<PropertiesEnvelope> {
        var path = "/users/{userId}/properties"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "aid": aid
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<PropertiesEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Get User Rules
     
     - parameter userId: (path) User ID. 
     - parameter excludeDisabled: (query) Exclude disabled rules in the result. (optional)
     - parameter count: (query) Desired count of items in the result set. (optional)
     - parameter offset: (query) Offset for pagination. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUserRules(userId: String, excludeDisabled: Bool? = nil, count: Int32? = nil, offset: Int32? = nil, completion: @escaping ((_ data: RulesEnvelope?, _ error: Error?) -> Void)) {
        getUserRulesWithRequestBuilder(userId: userId, excludeDisabled: excludeDisabled, count: count, offset: offset).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get User Rules
     
     - parameter userId: (path) User ID. 
     - parameter excludeDisabled: (query) Exclude disabled rules in the result. (optional)
     - parameter count: (query) Desired count of items in the result set. (optional)
     - parameter offset: (query) Offset for pagination. (optional)
     - returns: Promise<RulesEnvelope>
     */
    open class func getUserRules(userId: String, excludeDisabled: Bool? = nil, count: Int32? = nil, offset: Int32? = nil) -> Promise<RulesEnvelope> {
        let deferred = Promise<RulesEnvelope>.pending()
        getUserRules(userId: userId, excludeDisabled: excludeDisabled, count: count, offset: offset) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Get User Rules
     - GET /users/{userId}/rules
     - Retrieve User's Rules
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "total" : 123,
  "data" : [ {
    "languageVersion" : 123,
    "description" : "aeiou",
    "index" : 123,
    "rule" : {
      "key" : "{}"
    },
    "error" : {
      "messageKey" : "aeiou",
      "fieldPath" : {
        "path" : [ {
          "text" : "aeiou"
        } ]
      },
      "messageArgs" : [ "aeiou" ],
      "errorCode" : 123
    },
    "createdOn" : 123456789,
    "enabled" : true,
    "uid" : "aeiou",
    "modifiedOn" : 123456789,
    "name" : "aeiou",
    "warning" : {
      "code" : "aeiou",
      "message" : "aeiou"
    },
    "invalidatedOn" : 123456789,
    "id" : "aeiou",
    "aid" : "aeiou"
  } ],
  "offset" : 123,
  "count" : 123
}}]
     
     - parameter userId: (path) User ID. 
     - parameter excludeDisabled: (query) Exclude disabled rules in the result. (optional)
     - parameter count: (query) Desired count of items in the result set. (optional)
     - parameter offset: (query) Offset for pagination. (optional)

     - returns: RequestBuilder<RulesEnvelope> 
     */
    open class func getUserRulesWithRequestBuilder(userId: String, excludeDisabled: Bool? = nil, count: Int32? = nil, offset: Int32? = nil) -> RequestBuilder<RulesEnvelope> {
        var path = "/users/{userId}/rules"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "excludeDisabled": excludeDisabled,
            "count": count?.encodeToJSON(),
            "offset": offset?.encodeToJSON()
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<RulesEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Update User Application Properties
     
     - parameter userId: (path) User Id 
     - parameter properties: (body) Properties to be updated 
     - parameter aid: (query) Application ID (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateUserProperties(userId: String, properties: AppProperties, aid: String? = nil, completion: @escaping ((_ data: PropertiesEnvelope?, _ error: Error?) -> Void)) {
        updateUserPropertiesWithRequestBuilder(userId: userId, properties: properties, aid: aid).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Update User Application Properties
     
     - parameter userId: (path) User Id 
     - parameter properties: (body) Properties to be updated 
     - parameter aid: (query) Application ID (optional)
     - returns: Promise<PropertiesEnvelope>
     */
    open class func updateUserProperties(userId: String, properties: AppProperties, aid: String? = nil) -> Promise<PropertiesEnvelope> {
        let deferred = Promise<PropertiesEnvelope>.pending()
        updateUserProperties(userId: userId, properties: properties, aid: aid) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Update User Application Properties
     - PUT /users/{userId}/properties
     - Updates application properties of a user
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "uid" : "aeiou",
    "aid" : "aeiou",
    "properties" : "aeiou"
  }
}}]
     
     - parameter userId: (path) User Id 
     - parameter properties: (body) Properties to be updated 
     - parameter aid: (query) Application ID (optional)

     - returns: RequestBuilder<PropertiesEnvelope> 
     */
    open class func updateUserPropertiesWithRequestBuilder(userId: String, properties: AppProperties, aid: String? = nil) -> RequestBuilder<PropertiesEnvelope> {
        var path = "/users/{userId}/properties"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path
        
        let parameters = properties.encodeToJSON() as? [String:Any]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<PropertiesEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

}
