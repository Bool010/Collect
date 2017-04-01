//
//  WNAPIClient.swift
//  Wannar
//
//  Created by 付国良 on 2016/12/29.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

/// 请求类枚举
enum RequestType: Int {
    case get
    case post
}

/// 闭包
typealias CovertClosure = ((Any?) -> Any?)?
typealias SuccessClosure = ((JSON?) -> Void)?
typealias FailClosure = ((Error?) -> Void)?
typealias FinishClosure = ((Void) -> Void)?
typealias RequestParam = [String : Any]



class WNAPIClient: NSObject {
    
    // 网络请求
    class func request(method: RequestType,
                       url: String,
                       params: RequestParam,
                       isEncrypt: Bool? = false,
                       retryCount: Int? = 5,
                       delay: Double? = 3,
                       timeout: TimeInterval? = 30,
                       convertData: ((Any) -> JSON?)?,
                       success: ((JSON?) -> Void)?,
                       fail: ((Error?) -> Void)?,
                       finish: ((Void) -> Void)?) -> Void {
        
        func doFail(error: Error?) {
            if retryCount! > 0 {
                request(method: method, url: url, params: params, isEncrypt: isEncrypt, retryCount: retryCount!-1, delay: delay, timeout: timeout, convertData: convertData, success: success, fail: fail, finish: finish)
            } else {
                if let onFail = fail {
                    onFail(error)
                }
                if let onFinish = finish {
                    onFinish()
                }
            }
        }
        
        func doSuccess(data: Data?) {

            if let datas = data {
                let json: JSON = SwiftyJSON.JSON(data: datas)
                if let jsonError = json.error {
                    doFail(error: jsonError)
                    return
                }
                let convertResponse = convertData!(json)
                if convertResponse == nil {
                    let error: Error = NSError(domain: "Swift-APIClient Convert Data Error",
                                               code: 1,
                                               userInfo: [NSLocalizedFailureReasonErrorKey: "Convert Data Is Nil"])
                    doFail(error: error)
                    return
                }
                if let onSuccess = success {
                    onSuccess(convertResponse)
                }
                if let onFinish = finish {
                    onFinish()
                }
            }
        }
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: SessionManager.defaultHTTPHeaders).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                doSuccess(data: response.data)
            case .failure:
                doFail(error: response.result.error)
            }
        }
    }
    
    
    
    class func getSessionManager(timeout: TimeInterval) -> SessionManager {
        
        var manger:SessionManager? = nil
        
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeout
        manger = SessionManager(configuration: config)
        
        return manger!
    }
    
}
