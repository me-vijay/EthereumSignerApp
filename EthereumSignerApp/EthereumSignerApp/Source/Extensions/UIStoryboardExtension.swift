//
//  UIStoryboardExtension.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 21/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit

/// extension for instantiating view controllers from storyboard
extension UIStoryboard {
    //signing controller
    static var signingViewController: SigningViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: SigningViewController.storyboardIdentifier) as! SigningViewController
    }
    
    //verification controller
    static var verificationViewController: VerificationViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: VerificationViewController.storyboardIdentifier) as! VerificationViewController
    }
    
    //signature controller
    static var signatureViewController: SignatureViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: SignatureViewController.storyboardIdentifier) as! SignatureViewController
    }

    //QR code scanner controller
    static var qrCodeScannerViewController: QRCodeScannerViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: QRCodeScannerViewController.storyboardIdentifier) as! QRCodeScannerViewController
    }
}
