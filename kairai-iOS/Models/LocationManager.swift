//
//  Location.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/07.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func updatedLocations(locations: [CLLocation])
    func updatedAuthorization(status: CLAuthorizationStatus)
    func failedWithError(error: Error)
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    override init() {
        super.init()
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1
        self.locationManager.delegate = self
    }
    
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func setAccuracy(accuracy: CLLocationAccuracy) {
        self.locationManager.desiredAccuracy = accuracy
    }
    
    func setDistanceFilter(distanceFilter: Double) {
        self.locationManager.distanceFilter = distanceFilter
    }
    
    var isAvailable: Bool {
        if self.authorizationStatus == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        return CLLocationManager.locationServicesEnabled()
    }
    
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
        self.locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges() {
        self.locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    // CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = Location(
            latitude: locations.last!.coordinate.latitude,
            longitude: locations.last!.coordinate.longitude)
        self.delegate?.updatedLocations(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.failedWithError(error: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.delegate?.updatedAuthorization(status: status)
    }
    
    let locationManager = CLLocationManager()
    var currentLocation: Location?
    var delegate: LocationManagerDelegate?
}
