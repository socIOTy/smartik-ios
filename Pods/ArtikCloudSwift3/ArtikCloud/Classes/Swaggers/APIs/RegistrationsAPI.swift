//
// RegistrationsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire
import PromiseKit



open class RegistrationsAPI: APIBase {
    /**
     Confirm User
     
     - parameter registrationInfo: (body) Device Registration information. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func confirmUser(registrationInfo: DeviceRegConfirmUserRequest, completion: @escaping ((_ data: DeviceRegConfirmUserResponseEnvelope?, _ error: Error?) -> Void)) {
        confirmUserWithRequestBuilder(registrationInfo: registrationInfo).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Confirm User
     
     - parameter registrationInfo: (body) Device Registration information. 
     - returns: Promise<DeviceRegConfirmUserResponseEnvelope>
     */
    open class func confirmUser(registrationInfo: DeviceRegConfirmUserRequest) -> Promise<DeviceRegConfirmUserResponseEnvelope> {
        let deferred = Promise<DeviceRegConfirmUserResponseEnvelope>.pending()
        confirmUser(registrationInfo: registrationInfo) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Confirm User
     - PUT /devices/registrations/pin
     - This call updates the registration request issued earlier by associating it with an authenticated user and captures all additional information required to add a new device.
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "rid" : "aeiou"
  }
}}]
     
     - parameter registrationInfo: (body) Device Registration information. 

     - returns: RequestBuilder<DeviceRegConfirmUserResponseEnvelope> 
     */
    @available(*, renamed: "confirmUserXX", message: "Because !")
    open class func confirmUserWithRequestBuilder(registrationInfo: DeviceRegConfirmUserRequest) -> RequestBuilder<DeviceRegConfirmUserResponseEnvelope> {
        let path = "/devices/registrations/pin"
        let URLString = ArtikCloudAPI.basePath + path
        
        let parameters = registrationInfo.encodeToJSON() as? [String:Any]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<DeviceRegConfirmUserResponseEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    /**
     Get Request Status For User
     
     - parameter requestId: (path) Request ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getRequestStatusForUser(requestId: String, completion: @escaping ((_ data: DeviceRegStatusResponseEnvelope?, _ error: Error?) -> Void)) {
        getRequestStatusForUserWithRequestBuilder(requestId: requestId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get Request Status For User
     
     - parameter requestId: (path) Request ID. 
     - returns: Promise<DeviceRegStatusResponseEnvelope>
     */
    open class func getRequestStatusForUser(requestId: String) -> Promise<DeviceRegStatusResponseEnvelope> {
        let deferred = Promise<DeviceRegStatusResponseEnvelope>.pending()
        getRequestStatusForUser(requestId: requestId) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Get Request Status For User
     - GET /devices/registrations/{requestId}/status
     - This call checks the status of the request so users can poll and know when registration is complete.
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "did" : "aeiou",
    "status" : "aeiou"
  }
}}]
     
     - parameter requestId: (path) Request ID. 

     - returns: RequestBuilder<DeviceRegStatusResponseEnvelope> 
     */
    open class func getRequestStatusForUserWithRequestBuilder(requestId: String) -> RequestBuilder<DeviceRegStatusResponseEnvelope> {
        var path = "/devices/registrations/{requestId}/status"
        path = path.replacingOccurrences(of: "{requestId}", with: "\(requestId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path

        let requestBuilder: RequestBuilder<DeviceRegStatusResponseEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: nil, isBody: true)
    }

    /**
     Unregister Device
     
     - parameter deviceId: (path) Device ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func unregisterDevice(deviceId: String, completion: @escaping ((_ data: UnregisterDeviceResponseEnvelope?, _ error: Error?) -> Void)) {
        unregisterDeviceWithRequestBuilder(deviceId: deviceId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Unregister Device
     
     - parameter deviceId: (path) Device ID. 
     - returns: Promise<UnregisterDeviceResponseEnvelope>
     */
    open class func unregisterDevice(deviceId: String) -> Promise<UnregisterDeviceResponseEnvelope> {
        let deferred = Promise<UnregisterDeviceResponseEnvelope>.pending()
        unregisterDevice(deviceId: deviceId) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Unregister Device
     - DELETE /devices/{deviceId}/registrations
     - This call clears any associations from the secure device registration.
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "eid" : "aeiou",
    "uid" : "aeiou",
    "dtid" : "aeiou",
    "manifestVersion" : 123456789,
    "manifestVersionPolicy" : "aeiou",
    "name" : "aeiou",
    "certificateSignature" : "aeiou",
    "needProviderAuth" : true,
    "id" : "aeiou",
    "certificateInfo" : "aeiou",
    "createdOn" : 123456789
  }
}}]
     
     - parameter deviceId: (path) Device ID. 

     - returns: RequestBuilder<UnregisterDeviceResponseEnvelope> 
     */
    open class func unregisterDeviceWithRequestBuilder(deviceId: String) -> RequestBuilder<UnregisterDeviceResponseEnvelope> {
        var path = "/devices/{deviceId}/registrations"
        path = path.replacingOccurrences(of: "{deviceId}", with: "\(deviceId)", options: .literal, range: nil)
        let URLString = ArtikCloudAPI.basePath + path

        let requestBuilder: RequestBuilder<UnregisterDeviceResponseEnvelope>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: nil, isBody: true)
    }

}