//
//  Altimeter.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/03.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation
import CoreMotion

import SocketIO


class Barometer : CMSensor {
    
    override init(id: ProductId, spec: Dictionary<String,Any>) {
        super.init(id: id, spec: spec)
        self._type = .barometer
    }
    
    override var isAvailable: Bool {
        return CMAltimeter.isRelativeAltitudeAvailable()
    }
    
    override func startDataGeneration() {
        self.altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: self.recieve)
        super.startDataGeneration()
    }
    
    override func stopDataGeneration() {
        self.altimeter.stopRelativeAltitudeUpdates()
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
    
    fileprivate func recieve(_ data: CMAltitudeData?, error: Error?) -> Void {
        if let e = error {
            print(e)
        } else {
            if let d = data {
                let payload = [
                    "pressure": d.pressure.doubleValue
                ]
                self.send(data: payload)
            }
        }
    }
    
    let altimeter = CMAltimeter()
}
