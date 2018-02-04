//
//  File.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation

protocol SensorDelegate {
    func changedState(sensor: Sensor)
}

class Sensor : NSObject{
    init(productId: ProductId, spec: Dictionary<String,Any>) {
        self._productId = productId
        self._status = SensorStatus()
        self._type = .unavailableSensor
        self._spec = spec
    }
    
    var productId: ProductId {
        return self._productId
    }
    
    var type: SensorType {
        return self._type
    }
    
    var status: SensorStatus {
        return self._status
    }
    
    var name: String {
        return self._type.rawValue
    }
    
    var spec: Dictionary<String,Any> {
        return self._spec
    }

    func setSpec(name: String, value: Any) {
        self._spec[name] = value
    }
    
    func getSpec(name: String) -> Any {
        return self._spec[name]
    }
    
    var isAvailable: Bool {
        return false
    }
    
    func startDataGeneration() {
        self.status.transState = .active
        self.delegate?.changedState(sensor: self)
    }
    
    func stopDataGeneration() {
        self.status.transState = .ready
        self.delegate?.changedState(sensor: self)
    }
    
    let _productId: ProductId
    var _status: SensorStatus
    var _type: SensorType
    var _spec: Dictionary<String,Any>
    
    var delegate: SensorDelegate?
}
