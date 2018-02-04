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
    
    static func login(ownerId: String, password: String, callback: @escaping KairaiCallback) {
        let endPoint = [Resource.url, "owners", "login"].joined(separator: "/")
        let params = [
            "ownerId": ownerId,
            "password": password
        ]
        self.post(url: endPoint, params: params, callback: callback)
    }
    
    static func getMono(modelNumber: String, serialNumber: String, vendorName: String, callback: @escaping KairaiCallback) {
        let endPoint = [Resource.url, "monos"].joined(separator: "/")
        let params = [
            "modelNumber": modelNumber,
            "serialNumber": serialNumber,
            "vendorName": vendorName
        ]
        self.get(endPoint, params: params) { (err, data) in
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
    
    static func registerMono(modelNumber: String, serialNumber: String, vendorName: String, name: String, callback: @escaping KairaiCallback) {
        let endPoint = [Resource.url, "monos"].joined(separator: "/")
        let params = [
            "modelNumber": modelNumber,
            "serialNumber": serialNumber,
            "vendorName": vendorName,
            "name": name
        ]
        self.post(url: endPoint, params: params, callback: callback)
    }
    
    static func registerDataSource(
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
        self.post(url: endPoint, params: params, callback: callback)
    }
}
