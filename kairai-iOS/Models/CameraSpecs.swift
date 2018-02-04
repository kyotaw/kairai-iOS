//
//  CameraSpecs.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/02.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

public func getCameraSpec(modelName: String) -> Dictionary<String,Any> {
    switch modelName {
    case "iPhone 2G", "iPhone 3G":
        return getSpec(pixels: 2, colorSpaces: ["sRGB", "Adobe RGB"])
    case "iPhone 3GS":
        return getSpec(pixels: 3, colorSpaces: ["sRGB", "Adobe RGB"])
    case "iPhone 4":
        return getSpec(pixels: 5, colorSpaces: ["sRGB", "Adobe RGB"])
    case "iPhone 4S", "iPhone 5", "iPhone 5c", "iPhone 5s", "iPhone 6", "iPhone 6 Plus":
        return getSpec(pixels: 8, colorSpaces: ["sRGB", "Adobe RGB"])
    case "iPhone SE", "iPhone 6S", "iPhone 6S Plus":
        return getSpec(pixels: 12, colorSpaces: ["sRGB", "Adobe RGB"])
    case "iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus", "iPhone X":
        return getSpec(pixels: 12, colorSpaces: ["Display P3"])
    default:
        return getSpec(pixels: 0, colorSpaces: ["sRGB", "Adobe RGB"])
    }
}

fileprivate func getSpec(pixels: Int, colorSpaces: [String]) -> Dictionary<String,Any> {
    return [
        "totalPixels": 0,
        "effectivePixels": pixels,
        "colorSpaces": colorSpaces
    ]
}
