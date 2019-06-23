//
//  GnosisQRScannerDelegate.swift
//  GnosisQR
//
//  Created by Vijay Kumar on 22/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

@objc protocol GnosisQRScannerDelegate {
    func scanner(_ scanner: GnosisQRScanner, didScan result: String)
    func scanner(_ scanner: GnosisQRScanner, didFail error: Error)
}
