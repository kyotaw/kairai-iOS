//
//  SensorService.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/01/23.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

class SensorService {
    
    init(api: KairaiApi) {
        self.api = api
    }
    
    func regsiterSensor(sensor: Sensor, platform: Platform, callback: @escaping (MetaError?) -> Void) {
        self.api.registerDataSource(
            productId: sensor.productId,
            name: sensor.name,
            sourceType: sensor.type.rawValue,
            monoHash: platform.productId.hash,
            spec: sensor.spec) { err, data in
            if err != nil {
                callback(MetaError(errorType: .registerSensorFailed))
            } else {
                sensor.status.registerState = .registered
                sensor.productId.hash = data!["data"].dictionaryValue["hash"]!.stringValue
                callback(nil)
            }
        }
    }
    
    let api: KairaiApi
}
