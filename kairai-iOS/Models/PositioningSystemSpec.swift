//
//  GpsSpec.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/05.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

public func getPositioningSystemSpec(modelName: String) -> Dictionary<String, Any> {
    return [
        "accuracy": 3,
    ]
}
