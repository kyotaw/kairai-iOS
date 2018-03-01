//
//  Resource.swift
//  CCSwift
//
//  Created by 渡部郷太 on 2/19/17.
//
//

import Foundation

import Alamofire
import SwiftyJSON


internal class Resource {
    
    static func get(
        _ url: String,
        params: Dictionary<String, Any>=[:],
        headers: Dictionary<String, String>=[:],
        callback: @escaping KairaiCallback) {
        
        Alamofire.request(url, method: .get, parameters: params, headers: headers).responseJSON() { response in
            switch response.result {
            case .failure(_):
                callback(KairaiApiError(errorType: .connectionError), nil)
                return
            case .success:
                let data = JSON(response.result.value! as AnyObject)
                Resource.processResponse(res: data, callback: callback)
            }
        }
    }
    
    static func post(
        url: String,
        params: Dictionary<String, Any>,
        queryParams: Dictionary<String, String>=[:],
        headers: Dictionary<String, String>=[:],
        callback: @escaping KairaiCallback) {
        
        let queryUrl = self.addQueryParameters(url: url, params: queryParams)
        Alamofire.request(queryUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default
            )) {
                response in
                
                switch response.result {
                case .failure(_):
                    callback(KairaiApiError(errorType: .connectionError), nil)
                    return
                case .success:
                    let data = JSON(response.result.value! as AnyObject)
                    Resource.processResponse(res: data, callback: callback)
                }
        }
    }
    
    static func delete(
        url: String,
        headers: Dictionary<String, String>,
        callback: @escaping KairaiCallback) {
        
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default
            )) {
                response in
                
                switch response.result {
                case .failure(_):
                    
                    return
                case .success:
                    let _ = JSON(response.result.value! as AnyObject)

                }
        }
    }
    
    static func addQueryParameters(url: String, params: [String:String]) -> String {
        guard params.count > 0 else {
            return url
        }
        var queryUrl = url + "?"
        for (key, val) in params {
            queryUrl += "\(key)=\(val)&"
        }
        queryUrl.removeLast()
        return queryUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    static fileprivate func processResponse(res: JSON?, callback: KairaiCallback) {
        let status = res!["status"].stringValue
        if status == "error" {
            let code = res!["errorCode"].intValue
            let msg = res!["message"].stringValue
            if let errorType = KairaiApiErrorType(rawValue: code) {
                callback(KairaiApiError(errorType: errorType, message: msg), nil)
            } else {
                callback(KairaiApiError(errorType: .unknownError, message: msg), nil)
            }
        } else {
            callback(nil, res)
        }
    }
    
    internal static let url = "http://172.22.1.38:6171/api"
    //internal static let url = "https://kairai.herokuapp.com/api"
}
