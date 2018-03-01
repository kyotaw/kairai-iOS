//
//  SensorDetailViewController.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/01/22.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation
import UIKit

class SensorDetailViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.items?[0].title = self.sensor.type.rawValue
        
        self.sensorService = SensorService(api: getApp().account.api)
    }
    
    @IBAction func pushRegisterButton(_ sender: Any) {
        if self.sensor.status.isRegistered {
            return
        }
        self.sensorService.regsiterSensor(sensor: self.sensor, platform: self.platform) { err in
            if let e = err {
                let errorView = createErrorModal(title: e.errorType.rawValue, message: e.message) {_ in }
                self.present(errorView, animated: false, completion: nil)
            }
        }
    }
    
    var platform: Platform!
    var sensor: Sensor!
    var sensorService: SensorService!
}
