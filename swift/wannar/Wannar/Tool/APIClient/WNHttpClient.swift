//
//  WNHttpClient.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/7.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

public enum WNHTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

typealias WNRequestParam = [String : Any]


class WNHttpClient: NSObject {
    
    /// HTTPMethod Convert
    class func convertMethod(method: WNHTTPMethod) -> HTTPMethod {
        switch method {
        case .GET:
            return HTTPMethod.get
        case .POST:
            return HTTPMethod.post
        }
    }
    
    /// Base URL
    class func baseURL() -> String {
        return WNConfig.BaseURL.release
    }
    
    
    /// Session Manager
    class func getSessionManager(timeout: TimeInterval) -> SessionManager {
        
        var manger:SessionManager? = nil
        
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeout
        manger = SessionManager(configuration: config)
        
        return manger!
    }
    
    /// POST
    class func post(subURL: String,
                    param: WNRequestParam,
                    handle: ((Any) -> JSON?)?,
                    success: ((JSON?) -> Void)?,
                    fail: ((Error?) -> Void)?,
                    finish: ((Void) -> Void)?) -> Void {
        
        WNHttpClient.request(method: .POST,
                             subURL: subURL,
                             param: param,
                             handle: handle,
                             success: success,
                             fail: fail,
                             finish: finish)
        
    }
    
    /// GET
    class func get(subURL: String,
                   param: WNRequestParam,
                   handle: ((Any) -> JSON?)?,
                   success: ((JSON?) -> Void)?,
                   fail: ((Error?) -> Void)?,
                   finish: ((Void) -> Void)?) -> Void {
        
        WNHttpClient.request(method: .GET,
                             subURL: subURL,
                             param: param,
                             handle: handle,
                             success: success,
                             fail: fail,
                             finish: finish)
    }
    
    
    /// Request
    class func request(method: WNHTTPMethod,
                       baseURL: String = WNHttpClient.baseURL(),
                       subURL: String,
                       param: WNRequestParam,
                       retry: Int = 5,
                       delay: TimeInterval = 30,
                       handle: ((Any) -> JSON?)?,
                       success: ((JSON?) -> Void)?,
                       fail: ((Error?) -> Void)?,
                       finish: ((Void) -> Void)?) -> Void {
        
        let URL: String = baseURL + subURL
        let httpMethod: HTTPMethod = WNHttpClient.convertMethod(method: method)
        
        /// FAIL
        func doFail(error: Error?) {
            if retry > 0 {
                request(method: method,
                        baseURL: baseURL,
                        subURL: subURL,
                        param: param,
                        retry: retry,
                        delay: delay,
                        handle: handle,
                        success: success,
                        fail: fail,
                        finish: finish)
            } else {
                if let onFail = fail {
                    onFail(error)
                }
                if let onFinish = finish {
                    onFinish()
                }
            }
        }
        
        /// SUCCESS
        func doSuccess(data: Data?) {
            
            if let datas = data {
                let json: JSON = SwiftyJSON.JSON(data: datas)
                if let jsonError = json.error {
                    doFail(error: jsonError)
                    return
                }
                
                var handleResponse: JSON?
                if let handle = handle {
                    handleResponse = handle(json)
                    if handleResponse == nil {
                        let error: Error = NSError(domain: "Swift-APIClient Convert Data Error",
                                                   code: 1,
                                                   userInfo: [NSLocalizedFailureReasonErrorKey: "Convert Data Is Nil"])
                        doFail(error: error)
                        return
                    }
                }
                if let success = success {
                    success(handleResponse)
                }
                if let finish = finish {
                    finish()
                }
            }
        }
        
        Alamofire.request(URL, method: httpMethod, parameters: param, encoding: URLEncoding.default, headers: SessionManager.defaultHTTPHeaders).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                doSuccess(data: response.data)
            case .failure:
                doFail(error: response.result.error)
            }
        }
    }
}
