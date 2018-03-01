//
//  CMSensor.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation
import CoreMotion


class CMSensor : ConnectedSensor {

    override init(id: ProductId, name: String, spec: Dictionary<String,Any>) {
        self.motionManager = CMMotionManager()
        super.init(id: id, name: name, spec: spec)
    }
    
    let motionManager: CMMotionManager
}
