//
//  SensorListViewCell.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/13.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation
import UIKit

protocol SensorListViewCellDelegate {
    func touchesEnded(cell: SensorListViewCell)
    func pushedConnectButton(cell: SensorListViewCell)
    func pushedDisconnectButton(cell: SensorListViewCell)
    func pushedPictureButton(cell: SensorListViewCell)
    func sensorStateChanged(cell: SensorListViewCell, sensor: Sensor)
}

class SensorListViewCell : UITableViewCell, SensorDelegate {
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.delegate?.touchesEnded(cell: self)
    }
    
    // SensorDelegate
    func changedState(sensor: Sensor) {
        self.delegate?.sensorStateChanged(cell: self, sensor: self.sensor)
    }
    
    internal func setSensor(sensor: ConnectedSensor) {
        self.sensor = sensor
        sensor.delegate = self
        self.sensorNameLabel.text = sensor.name
        self.dataAmountLabel.text = 0.description
        self.dataUnitLabel.text = "MB"
        self.sensorStatus.text = sensor.status.currentState
        self.actions.removeAll()
        
        if sensor.status.isOffline && sensor.status.isRegistered {
            let action = UITableViewRowAction(style: .normal, title: "接続") { (_, _) in
                self.delegate?.pushedConnectButton(cell: self)
            }
            self.actions.append(action)
        } else if sensor.status.isOnline || sensor.status.isConnecting {
            let action = UITableViewRowAction(style: .normal, title: "切断") { (_, _) in
                self.delegate?.pushedDisconnectButton(cell: self)
            }
            self.actions.append(action)
            
            if sensor.type == .camera {
                let action = UITableViewRowAction(style: .normal, title: "撮影") { (_, _) in
                    self.delegate?.pushedPictureButton(cell: self)
                }
                self.actions.append(action)
            }
        }
    }
    
    @IBOutlet weak var sensorNameLabel: UILabel!
    @IBOutlet weak var dataAmountLabel: UILabel!
    @IBOutlet weak var dataUnitLabel: UILabel!
    @IBOutlet weak var sensorStatus: UILabel!
    
    var sensor: ConnectedSensor!
    var delegate: SensorListViewCellDelegate?
    
    var actions = [UITableViewRowAction]()
}
