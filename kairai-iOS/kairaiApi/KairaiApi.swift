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
    
    static func login(ownerId: String, password: String, callback: @escaping KairaiCallback) {
        KairaiResource.login(ownerId: ownerId, password: password, callback: callback)
    }
    
    static func getMono(productId: ProductId, callback: @escaping KairaiCallback) {
        KairaiResource.getMono(modelNumber: productId.modelNumber, serialNumber: productId.serialNumber, vendorName: productId.vendorName, callback: callback)
    }
    
    static func registerMono(productId: ProductId, name: String, callback: @escaping KairaiCallback) {
        KairaiResource.registerMono(modelNumber: productId.modelNumber, serialNumber: productId.serialNumber, vendorName: productId.vendorName, name: name, callback: callback)
    }
    
    static func registerDataSource(
        productId: ProductId,
        name: String,
        sourceType: String,
        monoHash: String,
        callback: @escaping KairaiCallback) {
        
        KairaiResource.registerDataSource(modelNumber: productId.modelNumber, serialNumber: productId.serialNumber, vendorName: productId.vendorName, name: name, sourceType: sourceType, monoHash: monoHash, callback: callback)
    }
}
