//
//  SensorService.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/01/23.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

class SenserService {
    
    static func regsiterSensor(sensor: Sensor, platform: Platform, callback: @escaping (MetaError?) -> Void) {
        KairaiApi.registerDataSource(productId: sensor.productId, name: sensor.name, sourceType: sensor.type.rawValue, monoHash: platform.productId.hash) { err, data in
            if err != nil {
                callback(MetaError(errorType: .registerSensorFailed))
            } else {
                sensor.status.registerState = .registered
                sensor.productId.hash = data!["data"].dictionaryValue["hash"]!.stringValue
                callback(nil)
            }
        }
    }
}
