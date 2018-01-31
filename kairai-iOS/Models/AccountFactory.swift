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
    static func create(json: JSON) -> Account? {
        guard let owner = json["owner"].dictionary else {
            return nil
        }
        guard let ownerId = owner["ownerId"]?.string else {
            return nil
        }
        return Account(ownerId: ownerId)
    }
}
