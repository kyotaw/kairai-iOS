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
    init(productId: ProductId, transferredBytes: Int) {
        self._productId = productId
        self._status = SensorStatus()
        self._type = .unavailableSensor
        self._transferredBytes = transferredBytes
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
    
    var isAvailable: Bool {
        return false
    }
    
    var transferredBytes: Int {
        get {
            return self._transferredBytes
        }
        set {
            self._transferredBytes = newValue
        }
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
    var _transferredBytes: Int
    
    var delegate: SensorDelegate?
}
