//
//  Accelerometer.swift
//  ThingsClient
//
//  Created by 渡部郷太 on 11/29/15.
//  Copyright © 2015 watanabe kyota. All rights reserved.
//

import Foundation
import CoreMotion

import SocketIO


class CMAccelerometer : CMSensor {
    
    override init(id: ProductId, transferredBytes: Int) {
        super.init(id: id, transferredBytes: transferredBytes)
        self._type = .accelerometer
    }
    
    override var isAvailable: Bool {
        return self.motionManager.isAccelerometerAvailable
    }
    
    override func startDataGeneration() {
        self.motionManager.accelerometerUpdateInterval = 0.3
        self.motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: self.recieve)
        super.startDataGeneration()
    }
    
    override func stopDataGeneration() {
        self.motionManager.stopAccelerometerUpdates()
    }
    
    override func onStart(data: StartData) {
        if self.status.isReady {
            self.startDataGeneration()
        }
    }
    
    override func onStop(data: StopData) {
        if self.status.isActive {
            self.stopDataGeneration()
        }
    }
    
    fileprivate func recieve(_ data: CMAccelerometerData?, error: Error?) -> Void {
        guard let accelX = data?.acceleration.x else {
            return
        }
        guard let accelY = data?.acceleration.y else {
            return
        }
        guard let accelZ = data?.acceleration.z else {
            return
        }
        let data = [
            "accelX": accelX,
            "accelY": accelY,
            "accelZ": accelZ
        ]
        self.send(data: data)
    }

}
