//
//  AccountService.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation


class AccountService {
    static func login(userId: String, password: String, callback: @escaping (MetaError?, Account?) -> Void) {
        KairaiApi.login(userId: userId, password: password) { (err, data) in
            if let e = err {
                callback(MetaError(errorType: .loginError, message: e.message), nil)
            } else {
                let account = AccountFactory.create(data: data!["data"])
                callback(nil, account)
            }
        }
    }
}
