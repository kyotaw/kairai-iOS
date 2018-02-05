//
//  PlatformFactory.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation
import UIKit

import SwiftyJSON


class PlatformFactory {
    
    static let vendorName = "Apple Inc."
    
    static func create() -> Platform? {
        guard let id = PlatformFactory.createProductId() else {
            return nil
        }
        var modelName = id.modelNumber
        if let name = PlatformList[id.modelNumber] {
            modelName = name
        }
        
        var sensors = [ConnectedSensor]()
        for type in SensorType.list {
            if let sensor = SensorFactory.create(sourceType: type.rawValue, productId: id, modelName: modelName) {
                sensors.append(sensor)
            }
        }
        return Platform(id: id, name: modelName, sensors: sensors)
    }
    
    static func create(data: JSON) -> Platform? {
        
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
        guard let name = data["name"].string else {
            return nil
        }
        let productId = ProductId(modelNumber: modelNumber, serialNumber: serialNumber, vendorName: vendorName, hash: hash)
        
        guard let dataSources = data["dataSources"].array else {
            return nil
        }
        
        var sensorList = SensorType.list
        
        var sensors = [ConnectedSensor]()
        
        // registered sensors
        for ds in dataSources {
            if let sensor = SensorFactory.create(data: ds) {
                sensor.status.registerState = .registered
                sensors.append(sensor)
                sensorList.remove(at: sensorList.index(of: sensor.type)!)
            }
        }
        
        var modelName = modelNumber
        if let name = PlatformList[modelNumber] {
            modelName = name
        }
        // not registered sensors
        for type in sensorList {
            let sensorId = ProductId(modelNumber: modelNumber + type.rawValue, serialNumber: serialNumber, vendorName: vendorName)
            if let sensor = SensorFactory.create(sourceType: type.rawValue, productId: sensorId, modelName: modelName) {
                if sensor.isAvailable {
                    sensors.append(sensor)
                }
            }
        }
        return Platform(id: productId, name: name, sensors: sensors)
    }
    
    static func createProductId() -> ProductId? {
        guard let model = PlatformFactory.modelNumber else {
            return nil
        }
        guard let modelId = PlatformFactory.serialNumber else {
            return nil
        }

        return ProductId(modelNumber: model, serialNumber: modelId, vendorName: PlatformFactory.vendorName)
    }
    
    static var modelNumber: String? {
        var size: Int = 0
        if sysctlbyname("hw.machine", nil, &size, nil, 0) != 0 {
            return nil
        }
        
        var value = [CChar](repeating: 0, count: size / MemoryLayout<CChar>.size)
        sysctlbyname("hw.machine", &value, &size, nil, 0)
        
        return String(cString: value)
    }
    
    static var serialNumber: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
}
