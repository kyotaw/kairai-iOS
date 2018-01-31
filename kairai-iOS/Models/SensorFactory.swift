//
//  SensorFactory.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation

import SwiftyJSON

class SensorFactory {
    
    static func create(data: JSON) -> ConnectedSensor? {
        guard let modelNumber = data["modelNumber"].string else {
            return nil
        }
        guard let serialNumber = data["serialNumber"].string else {
            return nil
        }
        guard let vendorName = data["vendorName"].string else {
            return nil
        }
        guard let hash = data["hash"].string else {
            return nil
        }
        guard let type = data["sourceType"].string else {
            return nil
        }
        guard let transferredBytes = data["transferredBytes"].int else {
            return nil
        }
        
        let productId = ProductId(modelNumber: modelNumber, serialNumber: serialNumber, vendorName: vendorName, hash: hash)
        return SensorFactory.create(sourceType: type, productId: productId, transferredBytes: transferredBytes)
    }
    
    static func create(sourceType: String, productId: ProductId, transferredBytes: Int) -> ConnectedSensor? {
        switch sourceType {
        case SensorType.accelerometer.rawValue:
            return CMAccelerometer(id: productId, transferredBytes: transferredBytes)
        case SensorType.barometer.rawValue:
            return nil
        case SensorType.beacon.rawValue:
            return nil
        case SensorType.brightnessSensor.rawValue:
            return nil
        case SensorType.fingerprintSensor.rawValue:
            return nil
        case SensorType.gps.rawValue:
            return nil
        case SensorType.gyroscope.rawValue:
            return nil
        case SensorType.led.rawValue:
            return nil
        case SensorType.magneticSensor.rawValue:
            return nil
        case SensorType.microphone.rawValue:
            return nil
        case SensorType.nfc.rawValue:
            return nil
        case SensorType.camera.rawValue:
            return Camera(id: productId, transferredBytes: transferredBytes)
        case SensorType.proximitySensor.rawValue:
            return nil
        default:
            return nil
        }
    }
}
