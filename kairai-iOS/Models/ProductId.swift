//
//  PlatformId.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation


class ProductId {
    
    init(modelNumber: String, serialNumber: String, vendorName: String, hash: String="") {
        self.modelNumber = modelNumber
        self.serialNumber = serialNumber
        self.vendorName = vendorName
        self._hash = hash
    }
    
    var hash: String {
        get { return self._hash}
        set { self._hash = newValue}
    }
    
    let modelNumber: String
    let serialNumber: String
    let vendorName: String
    fileprivate var _hash: String
}
