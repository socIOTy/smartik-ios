//
// TokensAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire
import PromiseKit



open class TokensAPI: APIBase {
    /**
     Check Token
     
     - parameter tokenInfo: (body) Token object to be checked 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func checkToken(tokenInfo: TokenRequest, completion: @escaping ((_ data: CheckTokenResponse?, _ error: Error?) -> Void)) {
        checkTokenWithRequestBuilder(tokenInfo: tokenInfo).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Check Token
     
     - parameter tokenInfo: (body) Token object to be checked 
     - returns: Promise<CheckTokenResponse>
     */
    open class func checkToken(tokenInfo: TokenRequest) -> Promise<CheckTokenResponse> {
        let deferred = Promise<CheckTokenResponse>.pending()
        checkToken(tokenInfo: tokenInfo) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Check Token
     - POST /accounts/checkToken
     - (Deprecated) Check Token. See tokenInfo
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "message" : "aeiou"
  }
}}]
     
     - parameter tokenInfo: (body) Token object to be checked 

     - returns: RequestBuilder<CheckTokenResponse> 
     */
    open class func checkTokenWithRequestBuilder(tokenInfo: TokenRequest) -> RequestBuilder<CheckTokenResponse> {
        let path = "/accounts/checkToken"
        let URLString = ArtikCloudAPI.basePath + path
        
        let parameters = tokenInfo.encodeToJSON() as? [String:Any]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<CheckTokenResponse>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    /**
     Refresh Token
     
     - parameter grantType: (form) Grant Type. 
     - parameter refreshToken: (form) Refresh Token. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func refreshToken(grantType: String, refreshToken: String, completion: @escaping ((_ data: RefreshTokenResponse?, _ error: Error?) -> Void)) {
        refreshTokenWithRequestBuilder(grantType: grantType, refreshToken: refreshToken).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Refresh Token
     
     - parameter grantType: (form) Grant Type. 
     - parameter refreshToken: (form) Refresh Token. 
     - returns: Promise<RefreshTokenResponse>
     */
    open class func refreshToken(grantType: String, refreshToken refreshTokenString: String) -> Promise<RefreshTokenResponse> {
        let deferred = Promise<RefreshTokenResponse>.pending()
        refreshToken(grantType: grantType, refreshToken: refreshTokenString) { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Refresh Token
     - POST /accounts/token
     - Refresh Token
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "access_token" : "aeiou",
  "refresh_token" : "aeiou",
  "token_type" : "aeiou",
  "expires_in" : 123456789
}}]
     
     - parameter grantType: (form) Grant Type. 
     - parameter refreshToken: (form) Refresh Token. 

     - returns: RequestBuilder<RefreshTokenResponse> 
     */
    open class func refreshTokenWithRequestBuilder(grantType: String, refreshToken: String) -> RequestBuilder<RefreshTokenResponse> {
        let path = "/accounts/token"
        let URLString = ArtikCloudAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "grant_type": grantType,
            "refresh_token": refreshToken
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<RefreshTokenResponse>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    /**
     Token Info
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func tokenInfo(_ completion: @escaping ((_ data: TokenInfoSuccessResponse?, _ error: Error?) -> Void)) {
        tokenInfoWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Token Info
     
     - returns: Promise<TokenInfoSuccessResponse>
     */
    open class func tokenInfo() -> Promise<TokenInfoSuccessResponse> {
        let deferred = Promise<TokenInfoSuccessResponse>.pending()
        tokenInfo() { data, error in
            if let error = error {
                deferred.reject(error)
            } else {
                deferred.fulfill(data!)
            }
        }
        return deferred.promise
    }

    /**
     Token Info
     - GET /accounts/tokenInfo
     - Returns the Token Information
     - OAuth:
       - type: oauth2
       - name: artikcloud_oauth
     - examples: [{contentType=application/json, example={
  "data" : {
    "device_id" : "aeiou",
    "user_id" : "aeiou",
    "expires_in" : 123,
    "client_id" : "aeiou"
  }
}}]

     - returns: RequestBuilder<TokenInfoSuccessResponse> 
     */
    open class func tokenInfoWithRequestBuilder() -> RequestBuilder<TokenInfoSuccessResponse> {
        let path = "/accounts/tokenInfo"
        let URLString = ArtikCloudAPI.basePath + path

        let requestBuilder: RequestBuilder<TokenInfoSuccessResponse>.Type = ArtikCloudAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: nil, isBody: true)
    }

}
