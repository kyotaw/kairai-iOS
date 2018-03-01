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
    init(id: ProductId, name: String, spec: Dictionary<String,Any>) {
        self._productId = id
        self._name = name
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
        return self._name
    }
    
    var spec: Dictionary<String,Any> {
        return self._spec
    }

    func setSpec(name: String, value: Any) {
        self._spec[name] = value
    }
    
    func getSpec(name: String) -> Any {
        guard let val = self._spec[name] else {
            return ""
        }
        return val
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
    
    var _productId: ProductId
    var _name: String
    var _status: SensorStatus
    var _type: SensorType
    var _spec: Dictionary<String,Any>
    var location: Location?
    
    var delegate: SensorDelegate?
}
