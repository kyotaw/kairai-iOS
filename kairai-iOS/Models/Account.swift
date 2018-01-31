//
//  Owner.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation


class Account {
    init(ownerId: String) {
        self.ownerId = ownerId
    }
    
    let ownerId: String
}
