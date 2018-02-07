//
//  FirstViewController.swift
//  Murmur-iOS
//
//  Created by 渡部郷太 on 2017/09/12.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import UIKit


class SensorsViewController: UIViewController, SensorListViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlatformService.getPlatrom() { (err, platform) in
            if let e = err {
                let errorView = createErrorModal(title: e.errorType.rawValue, message: e.message) {_ in }
                self.present(errorView, animated: false, completion: nil)
            } else {
                self.platform = platform
                self.sensorListView = SensorListView(
                    view: self.sensorTableView,
                    sensors: self.platform.sensors,
                    gps: self.platform.gps)
                self.sensorListView.delegate = self
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // SensorListViewDelegate
    func showDetail(sensor: Sensor) {
        self.performSegue(withIdentifier: self.sensorDetailSegue, sender: sensor)
    }
    
    func launchCamera(picker: UIImagePickerController) {
        present(picker, animated: true, completion: nil)
    }
    
    func shutdownCamera() {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ident = segue.identifier else {
            return
        }
        switch ident {
        case self.sensorDetailSegue:
            let dst = segue.destination as! UINavigationController
            let dstView = dst.viewControllers[0] as! SensorDetailViewController
            dstView.sensor = sender as! Sensor
            dstView.platform = self.platform
        default: break
        }
    }
    
    @IBAction func unwindToSensorList(segue: UIStoryboardSegue) {
        self.sensorListView.reloadData()
    }
    
    var platform: Platform!
    var sensorListView: SensorListView!
    
    let sensorDetailSegue = "sensorDetailSegue"
    
    @IBOutlet weak var sensorTableView: UITableView!
     
}

