//
//  Error.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation
import UIKit


public enum MetaErrorType : String {
    case loginError = "Login error"
    case deviceUnavailable = "Unavailable device"
    case registerSensorFailed = "Sensor register failed"
    case unknownError = "Unknown error"
}


public struct MetaError {
    public init(errorType: MetaErrorType, message: String="") {
        self.errorType = errorType
        self.message = message
    }
    
    public let errorType: MetaErrorType
    public let message: String
}


func createErrorModal(title: String="", message: String, handler: ((UIAlertAction) -> Void)?=nil) -> UIAlertController {
    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: handler)
    controller.addAction(action)
    return controller
}
