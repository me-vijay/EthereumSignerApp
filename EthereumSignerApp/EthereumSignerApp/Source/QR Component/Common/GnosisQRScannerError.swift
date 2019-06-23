//
//  Constants.swift
//  GnosisQR
//
//  Created by Vijay Kumar on 22/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

enum GnosisQRScannerError: Error {
    case deviceInitilizationFailed
    case videoSupportFailed
    
    func description() -> String {
        switch self {
        case .deviceInitilizationFailed:
            return "Device could not be initialized for scanning"
            
        case .videoSupportFailed:
            return "Video setup failed on this device"
        }
    }
}
