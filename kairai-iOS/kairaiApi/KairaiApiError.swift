//
//  Error.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation


public enum KairaiApiErrorType : Int {
    case connectionError = 10
    case invalidUrl = 11
    case invalidAuthInfo = 100
    case monoNotFound = 202
    case unknownError = 999
}

public struct KairaiApiError {
    public init(errorType: KairaiApiErrorType, message: String="") {
        self.errorType = errorType
        self.message = message
    }
    
    public let errorType: KairaiApiErrorType
    public let message: String
}
