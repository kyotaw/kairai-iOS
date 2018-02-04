//
//  ConnectedSensor.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/01/25.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

class ConnectedSensor : Sensor {
    override init(productId: ProductId, spec: Dictionary<String,Any>) {
        super.init(productId: productId, spec: spec)
        self.streamApi = KairaiStreamApi(
            dataSourceHash: productId.hash,
            onConnect: self.onConnect,
            onDisConnect: self.onDisconnect,
            onError: self.onError,
            onStart: self.onStart,
            onStop: self.onStop)
    }
    
    func connect() {
        if self.status.isOffline {
            self.streamApi.connect()
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
        self.delegate?.changedState(sensor: self)
    }
    
    func onStop(data: StopData) {
        self.status.transState = .ready
        self.delegate?.changedState(sensor: self)
    }
    
    func send(data: Dictionary<String, Double>) {
        self.streamApi.send(data: data)
    }
    
    func send(data: Dictionary<String, Any>) {
        self.streamApi.send(data: data)
    }
    
    var streamApi: KairaiStreamApi!
}
