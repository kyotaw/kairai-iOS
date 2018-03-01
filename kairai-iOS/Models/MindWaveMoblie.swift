//
//  MindWaveMoblie.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/18.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation
import CoreBluetooth

class MindWaveMoblie : ConnectedSensor, MWMDelegate {
    
    override init(id: ProductId, name: String, spec: Dictionary<String,Any>) {
        self.initialized = false
        super.init(id: id, name: name, spec: spec)
        self._type = .brainwaveSensor
        
        self.mwmDevice = MWMDevice.sharedInstance()
        self.mwmDevice.delegate = self
        self.mwmDevice.enableConsoleLog(true)
        self.mwmDevice.scanDevice()
        
    }
    
    override var isAvailable: Bool {
        return self.initialized
    }
    
    override func startDataGeneration() {
        self.mwmDevice.connect(self.productId.serialNumber)
        super.startDataGeneration()
    }
    
    override func stopDataGeneration() {
        self.mwmDevice.didConnect()
        super.stopDataGeneration()
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
    
    // MWMDelegate
    func deviceFound(_ devName: String!, mfgID: String!, deviceID: String!) {
        if self._productId.hash == "" {
            // not registered sensor, so recreate product id with MWW device id
            self._productId = ProductId(modelNumber: mfgID, serialNumber: deviceID, vendorName: "NeuroSky")
        }
        self._name = name
        self.initialized = true
        self.delegate?.changedState(sensor: self)
    }
    
    func didConnect() {
        print(self.productId.serialNumber + " connected")
    }
    
    func didDisconnect() {
        print(self.productId.serialNumber + " disconnected")
        if self.status.isActive {
            self.disconnect()
        }
    }
    
    func eegSample(_ sample: Int32) {
        print(sample)
    }
    
    func exceptionMessage(_ eventType: TGBleExceptionEvent) {
        print(eventType)
    }
    
    fileprivate var mwmDevice: MWMDevice!
    fileprivate var initialized: Bool
}
