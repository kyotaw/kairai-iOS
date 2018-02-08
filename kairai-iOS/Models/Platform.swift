//
//  iPhone.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 11/28/15.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation
import UIKit


class Platform {
    
    init(id: ProductId, name: String, sensors: [ConnectedSensor]) {
        self.productId = id
        self.sensors = sensors
        self._name = name
    }
    
    var name: String {
        get {
            return self._name
        }
        set {
            return self._name = newValue
        }
    }
    
    var positioningSystem: PositioningSystem? {
        for sensor in self.sensors {
            if sensor.type == .positioningSystem {
                return sensor as? PositioningSystem
            }
        }
        return nil
    }
    
    let productId: ProductId
    var sensors: [ConnectedSensor]
    var _name: String

}
