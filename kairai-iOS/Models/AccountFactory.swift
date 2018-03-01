//
//  AccountFactory.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation

import SwiftyJSON


class AccountFactory {
    static func create(data: JSON) -> Account? {
        guard let accessToken = data["accessToken"].string else {
            return nil
        }
        guard let userId = data["userId"].string else {
            return nil
        }
        return Account(userId: userId, accessToken: accessToken)
    }
}
