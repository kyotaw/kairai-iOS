//
//  StreamApi.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/01/24.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation

import SocketIO

public class ConnectData {
    
}

public class DisconnectData {
    
}

public class ErrorData {
    
}

public class StartData {
    
}

public class StopData {
    
}

public typealias OnConnectCB = ((ConnectData) -> Void)
public typealias OnDisconnectCB = ((DisconnectData) -> Void)
public typealias OnErrorCB = ((ErrorData) -> Void)
public typealias OnStartCB = ((StartData) -> Void)
public typealias OnStopCB = ((StopData) -> Void)

class KairaiStreamApi {
    init(
        onConnect: @escaping OnConnectCB,
        onDisConnect: @escaping OnDisconnectCB,
        onError: @escaping OnErrorCB,
        onStart: @escaping OnStartCB,
        onStop: @escaping OnStopCB) {
        
        self.socketManager = SocketManager(socketURL: URL(string: self.endPoint)!)
        self.socket = self.socketManager.socket(forNamespace: "/sources")
        
        self.onConnectCB = onConnect
        self.onDisconnectCB = onDisConnect
        self.onErrorCB = onError
        self.onStartCB = onStart
        self.onStopCB = onStop
        
        self.socket.on(clientEvent: .connect, callback: self.onConnect)
        self.socket.on(clientEvent: .disconnect, callback: self.onDisconnect)
        self.socket.on(clientEvent: .error, callback: self.onError)
        self.socket.on("start", callback: self.onStart)
        self.socket.on("stop", callback: self.onStop)
    }
    
    func connect(params: [String:Any]) {
        self.socketManager.config = [
            .log(true),
            .compress,
            .connectParams(params)
        ]
        self.socket.connect()
    }
    
    func disconnect() {
        self.socket.disconnect()
    }
    
    func send(data: Dictionary<String, Double>) {
        self.socket.emit("data", data)
    }
    
    func send(data: Dictionary<String, Any>) {
        self.socket.emit("data", data)
    }
    
    func onConnect(data : [Any], ack: SocketAckEmitter) {
        self.onConnectCB(ConnectData())
    }
    
    func onDisconnect(data : [Any], ack: SocketAckEmitter) {
        self.onDisconnectCB(DisconnectData())
    }
    
    func onError(data : [Any], ack: SocketAckEmitter) {
        self.onErrorCB(ErrorData())
    }
    
    func onStart(data : [Any], ack: SocketAckEmitter) {
        self.onStartCB(StartData())
    }
    
    func onStop(data : [Any], ack: SocketAckEmitter) {
        self.onStopCB(StopData())
    }
    
    let socketManager: SocketManager
    let socket: SocketIOClient
    let onConnectCB: OnConnectCB
    let onDisconnectCB: OnDisconnectCB
    let onErrorCB: OnErrorCB
    let onStartCB: OnStartCB
    let onStopCB: OnStopCB
    
    let endPoint = "http://172.22.1.11:6171/api/data_stream"
    //let endPoint = "https://kairai.herokuapp.com/api/data_stream"
}
