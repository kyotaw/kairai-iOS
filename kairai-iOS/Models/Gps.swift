//
//  Gps.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/05.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation
import CoreLocation

import SocketIO

class Gps : ConnectedSensor, CLLocationManagerDelegate {
    
    init(id: ProductId, spec: Dictionary<String,Any>) {
        super.init(productId: id, spec: spec)
        self._type = .gps
        
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1
        self.locationManager.delegate = self
    }
    
    func setAccuracy(accuracy: CLLocationAccuracy) {
        self.locationManager.desiredAccuracy = accuracy
    }
    
    func setDistanceFilter(distanceFilter: Double) {
        self.locationManager.distanceFilter = distanceFilter
    }

    override var isAvailable: Bool {
        if !CLLocationManager.locationServicesEnabled() {
            return false
        }
        self.updatePermission(status: CLLocationManager.authorizationStatus())
        return true
    }
    
    override func startDataGeneration() {
        self.locationManager.startUpdatingLocation()
        super.startDataGeneration()
    }
    
    override func stopDataGeneration() {
        self.locationManager.stopUpdatingLocation()
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
    
    // CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations.last!;
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.updatePermission(status: status)
        self.delegate?.changedState(sensor: self)
    }
    
    fileprivate func updatePermission(status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            self.status.hasPermission = false
            break
        case .denied:
            self.status.hasPermission = false
            break
        case .restricted:
            break
        case .authorizedAlways:
            self.status.hasPermission = true
            break
        case .authorizedWhenInUse:
            self.status.hasPermission = true
            break
        }
    }
    
    let locationManager = CLLocationManager.init()
}
