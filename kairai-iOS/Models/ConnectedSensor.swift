//
//  ConnectedSensor.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/01/25.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

class ConnectedSensor : Sensor {
    override init(id: ProductId, name: String, spec: Dictionary<String,Any>) {
        self.frameRate = 0
        self.prevTimestamp = 0
        super.init(id: id, name: name, spec: spec)
        self.streamApi = KairaiStreamApi(
            onConnect: self.onConnect,
            onDisConnect: self.onDisconnect,
            onError: self.onError,
            onStart: self.onStart,
            onStop: self.onStop)
    }
    
    func connect() {
        if self.status.isOffline {
            var params: [String:Any] = ["dataSourceHash": self.productId.hash]
            if let location = self.location {
                params["latitude"] = location.latitude
                params["longitude"] = location.longitude
            }
            self.streamApi.connect(params: params)
            self.status.connectionState = .connecting
            self.delegate?.changedState(sensor: self)
        }
    }
    
    func disconnect() {
        if !self.status.isOffline {
            self.streamApi.disconnect()
            self.delegate?.changedState(sensor: self)
        }
    }
    
    func onConnect(data: ConnectData) {
        self.status.connectionState = .online
        self.status.transState = .ready
        self.delegate?.changedState(sensor: self)
        print("Connected")
    }
    
    func onDisconnect(data: DisconnectData) {
        self.status.connectionState = .offline
        self.status.transState = .hold
        self.delegate?.changedState(sensor: self)
        print("Disconnected")
    }
    
    func onError(data: ErrorData) {
        print("Error")
    }
    
    func onStart(data: StartData) {
        self.status.transState = .active
        self.frameRate = 0
        self.prevTimestamp = timestamp()
        self.delegate?.changedState(sensor: self)
    }
    
    func onStop(data: StopData) {
        self.status.transState = .ready
        self.delegate?.changedState(sensor: self)
    }

    func send(data: Dictionary<String, Any>) {
        self.streamApi.send(data: data)
        self.updateFrameRate()
    }
    
    fileprivate func updateFrameRate() {
        let now = timestamp()
        let period = now - self.prevTimestamp
        if period > 0 {
            self.frameRate = Int(1.0 / (Double(period) / 1000.0))
        }
        self.prevTimestamp = now
    }
    
    var streamApi: KairaiStreamApi!
    
    var frameRate: Int
    var prevTimestamp: Int64
}
