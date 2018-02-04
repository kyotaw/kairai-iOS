//
//  AltimeterSpec.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/04.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

import Foundation

public func getBarometerSpec(modelName: String) -> Dictionary<String, Any> {
    return [
        "linearity": 3,
        "hysteresis": 0.0,
        "repeatability":0.0,
        "calibrationUncertainty": 0.0,
        "accuracy": 0.0
    ]
}
