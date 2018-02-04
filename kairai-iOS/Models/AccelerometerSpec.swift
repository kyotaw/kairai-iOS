//
//  AccelerometerSpec.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/03.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

public func getAccelerometerSpec(modelName: String) -> Dictionary<String, Any> {
    return [
        "axis": 3,
        "gRanges": [],
        "sensitivities": [],
        "noiseRange": [],
        "resolutions": []
    ]
}
