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
import ObjectMapper

public enum WNHTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

let selfSignedHosts = ["www.wannar.com"]

let SSCerKey = "MIIEJTCCAw2gAwIBAgIDAjp3MA0GCSqGSIb3DQEBCwUAMEIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1HZW9UcnVzdCBJbmMuMRswGQYDVQQDExJHZW9UcnVzdCBHbG9iYWwgQ0EwHhcNMTQwODI5MjEzOTMyWhcNMjIwNTIwMjEzOTMyWjBHMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5jLjEgMB4GA1UEAxMXUmFwaWRTU0wgU0hBMjU2IENBIC0gRzMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvVJvZWF0eLFbG1eh/9H0WA//Qi1rkjqfdVC7UBMBdmJyNkA+8EGVf2prWRHzAn7XpSowLBkMEu/SW4ib2YQGRZjEiwzQ0Xz8/kS9EX9zHFLYDn4ZLDqP/oIACg8PTH2lS1p1kD8mD5xvEcKyU58Okaiy9uJ5p2L4KjxZjWmhxgHsw3hUEv8zTvz5IBVV6s9cQDAP8m/0Ip4yM26eO8R5j3LMBL3+vV8M8SKeDaCGnL+enP/C1DPz1hNFTvA5yT2AMQriYrRmIV9cE7Ie/fodOoyH5U/02mEiN1vi7SPIpyGTRzFRIU4uvt2UevykzKdkpYEj4/5G8V1jlNS67abZZAgMBAAGjggEdMIIBGTAfBgNVHSMEGDAWgBTAephojYn7qwVkDBF9qn1luMrMTjAdBgNVHQ4EFgQUw5zz/NNGCDS7zkZ/oHxb8+IIy1kwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAQYwNQYDVR0fBC4wLDAqoCigJoYkaHR0cDovL2cuc3ltY2IuY29tL2NybHMvZ3RnbG9iYWwuY3JsMC4GCCsGAQUFBwEBBCIwIDAeBggrBgEFBQcwAYYSaHR0cDovL2cuc3ltY2QuY29tMEwGA1UdIARFMEMwQQYKYIZIAYb4RQEHNjAzMDEGCCsGAQUFBwIBFiVodHRwOi8vd3d3Lmdlb3RydXN0LmNvbS9yZXNvdXJjZXMvY3BzMA0GCSqGSIb3DQEBCwUAA4IBAQCjWB7GQzKsrC+TeLfqrlRARy1+eI1Q9vhmrNZPc9ZE768LzFvB9E+aj0l+YK/CJ8cW8fuTgZCpfO9vfm5FlBaEvexJ8cQO9K8EWYOHDyw7l8NaEpt7BDV7o5UzCHuTcSJCs6nZb0+BkvwHtnm8hEqddwnxxYny8LScVKoSew26T++TGezvfU5ho452nFnPjJSxhJf3GrkHuLLGTxN5279PURt/aQ1RKsHWFf83UTRlUfQevjhq7A6rvz17OQV79PP7GqHQyH5OZI3NjGFVkP46yl0lD/gdo0p0Vk8aVUBwdSWmMy66S6VdU5oNMOGNX2Esr8zvsJmhgP8L8mJMcCaY"

// 定义一个结构体，存储认证相关信息
struct IdentityAndTrust {
    var identityRef: SecIdentity
    var trust: SecTrust
    var certArray: AnyObject
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
                    success: ((String) -> Void)? = nil,
                    fail: ((Error?) -> Void)? = nil,
                    finish: ((Void) -> Void)? = nil) -> Void {
        
        WNHttpClient.request(method: .POST, subURL: subURL, param: param, success: success, fail: fail, finish: finish)
        
    }
    
    /// GET
    class func get(subURL: String, param: WNRequestParam, success: ((String) -> Void)?, fail: ((Error?) -> Void)?, finish: ((Void) -> Void)?) -> Void {
        WNHttpClient.request(method: .GET, subURL: subURL, param: param, success: success, fail: fail, finish: finish)
    }
    
    
    /// Request
    class func request(method: WNHTTPMethod,
                       baseURL: String = WNHttpClient.baseURL(),
                       subURL: String,
                       param: WNRequestParam,
                       retry: Int = 5,
                       delay: TimeInterval = 30,
                       success: ((String) -> Void)? = nil,
                       fail: ((Error?) -> Void)? = nil,
                       finish: ((Void) -> Void)? = nil) -> Void {
        
        let URL: String = baseURL + subURL
        let httpMethod: HTTPMethod = WNHttpClient.convertMethod(method: method)
        
        /// FAIL
        func doFail(error: Error?) {
            if retry > 0 {
                DispatchQueue.delay(delay, task: { 
                    request(method: method, baseURL: baseURL, subURL: subURL, param: param, retry: retry, delay: delay, success: success, fail: fail, finish: finish)
                })
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
        func doSuccess(data: String?) {
                        
            if let json = data {
                if let success = success {
                    success(json)
                }
                if let finish = finish {
                    finish()
                }
            } else {
                let error: Error = NSError(domain: "Swift-APIClient Convert Data Error", code: 1, userInfo: [NSLocalizedFailureReasonErrorKey: "Convert Data Is Nil"])
                doFail(error: error)
            }
        }
        
        Alamofire.request(URL, method: httpMethod, parameters: param, encoding: URLEncoding.default, headers: SessionManager.defaultHTTPHeaders).validate().responseString { (response) in
            switch response.result {
            case .success:
                doSuccess(data: response.value)
            case .failure:
                doFail(error: response.result.error)
            }
        }
    }
    
    class func sessionManager() -> Void {
        
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            // 认证服务器（这里不使用服务器证书认证，只需地址是我们定义的几个地址即可信任）
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust &&
                selfSignedHosts.contains(challenge.protectionSpace.host) {
                
                print("服务器认证！")
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                return (.useCredential, credential)
            }
            //认证客户端证书
            else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate {
                print("客户端证书认证！")
                //获取客户端证书相关信息
                let identityAndTrust:IdentityAndTrust = self.extractIdentity();
                
                let urlCredential:URLCredential = URLCredential(
                    identity: identityAndTrust.identityRef,
                    certificates: identityAndTrust.certArray as? [AnyObject],
                    persistence: URLCredential.Persistence.forSession);
                
                return (.useCredential, urlCredential);
            }
            // 其它情况（不接受认证）
            else {
                print("其它情况（不接受认证）")
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }
    
    // 获取客户端证书相关信息
    class func extractIdentity() -> IdentityAndTrust {
        
        var identityAndTrust:IdentityAndTrust!
        var securityError:OSStatus = errSecSuccess
        
        let PKCS12Data = Data.init(base64Encoded: SSCerKey)
        let key: String = kSecImportExportPassphrase as String
        let options : NSDictionary = [key : ""]  // 客户端证书密码
        
        var items : CFArray?
        
        securityError = SecPKCS12Import(PKCS12Data! as CFData, options, &items)
        
        if securityError == errSecSuccess {
            let certItems:CFArray = items as CFArray!;
            let certItemsArray:Array = certItems as Array
            let dict:AnyObject? = certItemsArray.first;
            if let certEntry:Dictionary = dict as? Dictionary<String, AnyObject> {
                // grab the identity
                let identityPointer:AnyObject? = certEntry["identity"];
                let secIdentityRef:SecIdentity = identityPointer as! SecIdentity!
                
                // grab the trust
                let trustPointer:AnyObject? = certEntry["trust"]
                let trustRef:SecTrust = trustPointer as! SecTrust
                
                // grab the cert
                let chainPointer:AnyObject? = certEntry["chain"]
                identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef,
                                                    trust: trustRef,
                                                    certArray: chainPointer!)
            }
        }
        return identityAndTrust;
    }
}
