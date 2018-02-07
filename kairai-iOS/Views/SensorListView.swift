//
//  SensorListView.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/13.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation
import UIKit

protocol SensorListViewDelegate {
    func showDetail(sensor: Sensor)
    func launchCamera(picker: UIImagePickerController)
    func shutdownCamera()
}

class SensorListView : NSObject, UITableViewDelegate, UITableViewDataSource, SensorListViewCellDelegate {
    
    init(view: UITableView, sensors: [ConnectedSensor], gps: Gps?) {
        self.view = view
        self.sensors = sensors
        self.gps = gps
        self.view.tableFooterView = UIView()
        
        super.init()
        self.view.delegate = self
        self.view.dataSource = self
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sensors.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sensorListViewCell", for: indexPath) as! SensorListViewCell
        let row = indexPath.row
        let sensor = self.sensors[row]
        cell.setSensor(sensor: sensor)
        cell.delegate = self
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let cell = self.view.cellForRow(at: indexPath) as? SensorListViewCell else {
            return nil
        }
        
        if cell.actions.count == 0 {
            let empty = UITableViewRowAction(style: .normal, title: nil) { (_, _) in }
            empty.backgroundColor = UIColor.white
            return [empty]
        } else {
            return cell.actions
        }
    }
    
    // SensorListViewCellCellDelegate
    func touchesEnded(cell: SensorListViewCell) {
        self.delegate?.showDetail(sensor: cell.sensor)
    }
    
    func pushedConnectButton(cell: SensorListViewCell) {
        if let gps = self.gps {
            cell.sensor.location = gps.currentLocation
        }
        cell.sensor.connect()
    }
    
    func pushedDisconnectButton(cell: SensorListViewCell) {
        cell.sensor.disconnect()
    }
    
    func sensorStateChanged(cell: SensorListViewCell, sensor: Sensor) {
        self.reloadData()
    }
    
    func pushedPictureButton(cell: SensorListViewCell) {
        let camera = cell.sensor as! Camera
        camera.startDataGeneration()
        self.delegate?.launchCamera(picker: camera.picker)
    }
    
    internal func reloadData() {
        self.view.reloadData()
    }
    
    var delegate: SensorListViewDelegate?
    
    fileprivate let sensors: [ConnectedSensor]
    fileprivate let gps: Gps?
    fileprivate let view: UITableView
    
}
