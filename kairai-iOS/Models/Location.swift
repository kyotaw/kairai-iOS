//
//  Location.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/07.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

class Location {
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    let latitude: Double
    let longitude: Double
}
