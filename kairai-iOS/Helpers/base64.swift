//
//  base64.swift
//  kairai-iOS
//
//  Created by 渡部郷太 on 2018/02/01.
//  Copyright © 2018 watanabe kyota. All rights reserved.
//

import Foundation
import UIKit

func encodePngBase64(image: UIImage) -> String? {
    guard let png = UIImagePNGRepresentation(image) else {
        return nil
    }
    return png.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
}
