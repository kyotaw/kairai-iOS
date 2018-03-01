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
        guard let name = data["name"].string else {
            return nil
        }
        
        let productId = ProductId(modelNumber: modelNumber, serialNumber: serialNumber, vendorName: vendorName, hash: hash)
        let sensor = SensorFactory.create(sourceType: type, productId: productId, name: name, modelName: "")
        
        if let spec = data["spec"].dictionary {
            for (name, value) in spec {
                sensor?.setSpec(name: name, value: value.object)
            }
        }
        
        return sensor;
    }
    
    static func create(sourceType: String, productId: ProductId, name: String, modelName: String) -> ConnectedSensor? {
        switch sourceType {
        case SensorType.accelerometer.rawValue:
            return Accelerometer(id: productId, name: name, spec: getAccelerometerSpec(modelName: modelName))
        case SensorType.barometer.rawValue:
            return Barometer(id: productId, name: name, spec: getBarometerSpec(modelName: modelName))
        case SensorType.beacon.rawValue:
            return nil
        case SensorType.brightnessSensor.rawValue:
            return nil
        case SensorType.fingerprintSensor.rawValue:
            return nil
        case SensorType.positioningSystem.rawValue:
            return PositioningSystem(id: productId, name: name, spec: getPositioningSystemSpec(modelName: modelName))
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
            return Camera(id: productId, name: name, spec: getCameraSpec(modelName: modelName))
        case SensorType.proximitySensor.rawValue:
            return nil
        case SensorType.brainwaveSensor.rawValue:
            return MindWaveMoblie(id: productId, name: name, spec: [String:Any]());
        default:
            return nil
        }
    }
}
