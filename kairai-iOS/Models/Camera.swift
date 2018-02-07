//
//  OutCamera.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/01/31.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation
import UIKit

class Camera : ConnectedSensor, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    init(id: ProductId, spec: Dictionary<String,Any>) {
        self.picker = UIImagePickerController()
        self.picker.sourceType = UIImagePickerControllerSourceType.camera
        super.init(productId: id, spec: spec)
        self._type = .camera
    }
    
    override var isAvailable: Bool {
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
    }
    
    override func startDataGeneration() {
        self.picker.delegate = self
    }
    
    override func stopDataGeneration() {
        self.picker.delegate = nil
    }
    
    override func onStart(data: StartData) {
        if self.status.isReady {
            self.status.transState = .active
            self.delegate?.changedState(sensor: self)
        }
    }
    
    override func onStop(data: StopData) {
        if self.status.isActive {
            self.status.transState = .ready
            self.delegate?.changedState(sensor: self)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if let imageData = encodePngBase64(image: image) {
            let width = image.cgImage!.width
            let height = image.cgImage!.height
            let data: [String:Any] = [
                "width": width,
                "height": height,
                "data": imageData,
                "format": "png",
                "timestamp": timestamp()
            ]
            self.send(data: data)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    var picker: UIImagePickerController
}

