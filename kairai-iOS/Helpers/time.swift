//
//  time.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/07.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

func timestamp() -> Int64 {
    return Int64(Date().timeIntervalSince1970)
}
