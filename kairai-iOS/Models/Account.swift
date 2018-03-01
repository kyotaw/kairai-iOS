//
//  Owner.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation


class Account {
    init(userId: String, accessToken: String) {
        self.userId = userId
        self.accessToken = accessToken
        self.api = KairaiApi(accessToken: accessToken)
    }
    
    let api: KairaiApi
    let userId: String
    let accessToken: String
}
