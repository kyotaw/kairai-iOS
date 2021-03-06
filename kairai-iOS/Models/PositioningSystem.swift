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

class PositioningSystem : ConnectedSensor, LocationManagerDelegate {
    
    override init(id: ProductId, name: String, spec: Dictionary<String,Any>) {
        super.init(id: id, name: name, spec: spec)
        self._type = .positioningSystem
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation() // get current location
    }

    override var isAvailable: Bool {
        if !self.locationManager.isAvailable {
            return false
        }
        self.updatePermission(status: self.locationManager.authorizationStatus)
        return true
    }
    
    override func startDataGeneration() {
        self.locationManager.startUpdatingLocation()
        super.startDataGeneration()
    }
    
    override func stopDataGeneration() {
        self.locationManager.stopUpdatingLocation()
        super.stopDataGeneration()
    }
    
    override func onStart(data: StartData) {
        if self.status.isReady {
            self.locationManager.stopMonitoringSignificantLocationChanges()
            self.startDataGeneration()
        }
    }
    
    override func onStop(data: StopData) {
        if self.status.isActive {
            self.stopDataGeneration()
            self.locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    var currentLocation: Location? {
        return self.locationManager.currentLocation
    }
    
    // LocationDelegate
    
    func updatedLocations(locations: [CLLocation]) {
        if self.status.isActive {
            let location : CLLocation = locations.last!
            let data: [String:Any] = [
                "location": [
                    "latitude": location.coordinate.latitude,
                    "longitude": location.coordinate.longitude,
                ],
                "timestamp": timestamp()
            ]
            self.send(data: data)
        } else {
            // completed filling current location so switch to significant-location mode.
            self.locationManager.stopUpdatingLocation()
            self.locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func updatedAuthorization(status: CLAuthorizationStatus) {
        self.updatePermission(status: status)
        self.delegate?.changedState(sensor: self)
    }
    
    func failedWithError(error: Error) {
    }

    fileprivate func updatePermission(status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
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
    
    var locationManager = LocationManager()
}
