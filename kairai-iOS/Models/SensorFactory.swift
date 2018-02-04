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
        
        let productId = ProductId(modelNumber: modelNumber, serialNumber: serialNumber, vendorName: vendorName, hash: hash)
        let sensor = SensorFactory.create(sourceType: type, productId: productId, modelName: "")
        
        if let spec = data["spec"].dictionary {
            for (name, value) in spec {
                sensor?.setSpec(name: name, value: value.object)
            }
        }
        
        return sensor;
    }
    
    static func create(sourceType: String, productId: ProductId, modelName: String) -> ConnectedSensor? {
        switch sourceType {
        case SensorType.accelerometer.rawValue:
            return Accelerometer(id: productId, spec: getAccelerometerSpec(modelName: modelName))
        case SensorType.barometer.rawValue:
            return Barometer(id: productId, spec: getBarometerSpec(modelName: modelName))
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
            return Camera(id: productId, spec: getCameraSpec(modelName: modelName))
        case SensorType.proximitySensor.rawValue:
            return nil
        default:
            return nil
        }
    }
}
