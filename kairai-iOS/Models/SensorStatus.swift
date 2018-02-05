//
//  SensorStatus.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/13.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation


enum ConnectionState : String {
    case online = "Online"
    case offline = "Offline"
    case connecting = "Connecting"
}


enum TransferState : String {
    case ready = "Ready"
    case active = "Active"
    case hold = "Hold"
}


enum RegisterState : String {
    case notRegistered = "Not Registered"
    case registered = "Registered"
}


class SensorStatus {

    init() {
        self.connState = .offline
        self.transState = .hold
        self.regState = .notRegistered
        self.hasPermission = true
    }
    
    init(connState: ConnectionState, transState: TransferState, regState: RegisterState) {
        self.connState = connState
        self.transState = transState
        self.regState = regState
        self.hasPermission = true
    }
    
    var connectionState: ConnectionState {
        get {
            return self.connState
        }
        set {
            self.connState = newValue
        }
    }
    
    var transferState: TransferState {
        get {
            return self.transState
        }
        set {
            self.transState = newValue
        }
    }
    
    var registerState: RegisterState {
        get {
            return self.regState
        }
        set {
            self.regState = newValue
        }
    }
    
    var isOnline: Bool {
        return self.connState == .online
    }
    
    var isOffline: Bool {
        return self.connState == .offline
    }
    
    var isConnecting: Bool {
        return self.connState == .connecting
    }
    
    var isReady: Bool {
        return self.transState == .ready
    }
    
    var isActive: Bool {
        return self.transState == .active
    }
    
    var isRegistered: Bool {
        return self.regState == .registered
    }
    
    var currentState: String {
        if self.isRegistered == false {
            return self.regState.rawValue
        }
        if self.isOffline || self.isConnecting {
            return self.connState.rawValue
        }
        return self.transState.rawValue
    }
    
    
    var connState: ConnectionState
    var transState: TransferState
    var regState: RegisterState
    var hasPermission: Bool
}
