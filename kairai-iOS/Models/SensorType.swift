//
//  SensorType.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation


enum SensorType : String {
    case fingerprintSensor = "fingerprintSensor"
    case proximitySensor = "proximitySensor"
    case positioningSystem = "positioningSystem"
    case accelerometer = "accelerometer"
    case gyroscope = "gyroscope"
    case magneticSensor = "magneticSensor"
    case led = "led"
    case brightnessSensor = "brightnessSensor"
    case vibrator = "vibrator"
    case microphone = "microphone"
    case speaker = "speaker"
    case camera = "camera"
    case beacon = "beacon"
    case nfc = "nfc"
    case barometer = "barometer"
    case brainwaveSensor = "brainwaveSensor"
    case unavailableSensor = "unavailableSensor"
    
    static var list: [SensorType] {
        return [
            .fingerprintSensor,
            .proximitySensor,
            .positioningSystem,
            .accelerometer,
            .gyroscope,
            .magneticSensor,
            .led,
            .brightnessSensor,
            .vibrator,
            .microphone,
            .speaker,
            .camera,
            .beacon,
            .nfc,
            .barometer,
            .brainwaveSensor
        ]
    }
}
