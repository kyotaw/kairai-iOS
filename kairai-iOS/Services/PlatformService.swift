//
//  PlatformService.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation

import SwiftyJSON

class PlatformService {
    
    init(api: KairaiApi) {
        self.api = api
    }
    
    func getPlatrom(callback: @escaping (MetaError?, Platform?) -> Void) {
        guard let productId = PlatformFactory.createProductId() else {
            callback(MetaError(errorType: .deviceUnavailable), nil)
            return
        }
        self.api.getMono(productId: productId) { (err, data) in
            if err == nil {
                guard let monoData = data?["data"].array?.first else {
                    callback(MetaError(errorType: .deviceUnavailable), nil)
                    return
                }
                guard let platform = PlatformFactory.create(data: monoData) else {
                    callback(MetaError(errorType: .deviceUnavailable), nil)
                    return
                }
                callback(nil, platform)
            } else if err!.errorType == .monoNotFound {
                self.api.registerMono(productId: productId, name: PlatformFactory.defaultPlatformName) { (err, data) in
                    if let e = err {
                        callback(MetaError(errorType: .deviceUnavailable, message: e.message), nil)
                    } else {
                        guard let monoData = data?["data"] else {
                            callback(MetaError(errorType: .deviceUnavailable), nil)
                            return
                        }
                        guard let platform = PlatformFactory.create(data: monoData) else {
                            callback(MetaError(errorType: .deviceUnavailable), nil)
                            return
                        }
                        callback(nil, platform)
                    }
                }
            } else {
                callback(MetaError(errorType: .deviceUnavailable), nil)
            }
        }
    }
    
    let api: KairaiApi
}
