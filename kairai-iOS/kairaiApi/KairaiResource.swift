//
//  KairaiResource.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation

import SwiftyJSON

internal class KairaiResource : Resource {
    
    init(accessToken: String) {
        self.acccessToken = accessToken
    }
    
    static func login(userId: String, password: String, callback: @escaping KairaiCallback) {
        let endPoint = [Resource.url, "auth", "login"].joined(separator: "/")
        let params = [
            "userId": userId,
            "password": password
        ]
        Resource.get(endPoint, params: params, callback: callback)
    }
    
    func getMono(modelNumber: String, serialNumber: String, vendorName: String, callback: @escaping KairaiCallback) {
        let endPoint = [Resource.url, "monos"].joined(separator: "/")
        let params = [
            "modelNumber": modelNumber,
            "serialNumber": serialNumber,
            "vendorName": vendorName
        ]
        let headers = self.makeHeaders()
        Resource.get(endPoint, params: params, headers: headers) { (err, data) in
            if (err != nil) {
                callback(err, nil)
            } else {
                if data!["data"].array?.first == nil {
                    callback(KairaiApiError(errorType: .monoNotFound), nil)
                } else {
                    callback(err, data)
                }
            }
        }
    }
    
    func registerMono(modelNumber: String, serialNumber: String, vendorName: String, name: String, callback: @escaping KairaiCallback) {
        let endPoint = [Resource.url, "monos"].joined(separator: "/")
        let params = [
            "modelNumber": modelNumber,
            "serialNumber": serialNumber,
            "vendorName": vendorName,
            "name": name
        ]
        let headers = self.makeHeaders()
        Resource.post(url: endPoint, params: params, headers: headers, callback: callback)
    }
    
    func registerDataSource(
        modelNumber: String,
        serialNumber: String,
        vendorName: String,
        name: String,
        sourceType: String,
        monoHash: String,
        spec: Dictionary<String,Any>,
        callback: @escaping KairaiCallback) {
        
        let endPoint = [Resource.url, "monos", monoHash, "data_sources"].joined(separator: "/")
        let params: [String:Any] = [
            "modelNumber": modelNumber,
            "serialNumber": serialNumber,
            "vendorName": vendorName,
            "name": name,
            "sourceType": sourceType,
            "spec": spec
            ]
        let headers = self.makeHeaders()
        Resource.post(url: endPoint, params: params, headers: headers, callback: callback)
    }
    
    fileprivate func makeHeaders() -> [String:String] {
        return [
            "Authorization": "Bearer " + self.acccessToken
        ]
    }
    
    let acccessToken: String
}
