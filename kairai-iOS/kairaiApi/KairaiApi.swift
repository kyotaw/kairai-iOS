//
//  kairaiApi.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation

import SwiftyJSON


public typealias KairaiCallback = ((_ err: KairaiApiError?, _ res: JSON?) -> Void)


public class KairaiApi {
    
    init(accessToken: String) {
        self.resource = KairaiResource(accessToken: accessToken)
    }
    
    static func login(userId: String, password: String, callback: @escaping KairaiCallback) {
        KairaiResource.login(userId: userId, password: password, callback: callback)
    }
    
    func getMono(productId: ProductId, callback: @escaping KairaiCallback) {
        self.resource.getMono(modelNumber: productId.modelNumber, serialNumber: productId.serialNumber, vendorName: productId.vendorName, callback: callback)
    }
    
    func registerMono(productId: ProductId, name: String, callback: @escaping KairaiCallback) {
        self.resource.registerMono(modelNumber: productId.modelNumber, serialNumber: productId.serialNumber, vendorName: productId.vendorName, name: name, callback: callback)
    }
    
    func registerDataSource(
        productId: ProductId,
        name: String,
        sourceType: String,
        monoHash: String,
        spec: Dictionary<String,Any>,
        callback: @escaping KairaiCallback) {
        
        self.resource.registerDataSource(modelNumber: productId.modelNumber, serialNumber: productId.serialNumber, vendorName: productId.vendorName, name: name, sourceType: sourceType, monoHash: monoHash, spec: spec, callback: callback)
    }
    
    let resource: KairaiResource
}
