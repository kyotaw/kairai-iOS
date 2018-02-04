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

    init(id: ProductId, spec: Dictionary<String,Any>) {
        self.motionManager = CMMotionManager()
        super.init(productId: id, spec: spec)
    }
    
    let motionManager: CMMotionManager
}
