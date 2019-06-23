//
//  UIAlertControllerExtension.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 20/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

///extension for default alerts
extension UIAlertController {
    
    //invalid key alert
    static var invalidKeyAlert: UIAlertController {
            let alert = UIAlertController(title:Alert.invalidKey.title, message:Alert.invalidKey.message , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Alert.invalidKey.okButton, style: .default, handler: nil))
            
            return alert
    }
    
    //balance fetch fail alert
    static var balanceFetchAlert: UIAlertController {
        let alert = UIAlertController(title: Alert.balanceFetchFailure.title, message: Alert.balanceFetchFailure.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.balanceFetchFailure.okButton, style: .default, handler: nil))

        return alert
    }
    
    //signing fail alert
    static var signingFailedAlert: UIAlertController {
        let alert = UIAlertController(title: Alert.signingFailure.title, message: Alert.signingFailure.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.signingFailure.okButton, style: .default, handler: nil))
        
        return alert
    }
    
    //QR code scanning fail alert
    static var scanningFailedAlert: UIAlertController {
        let alert = UIAlertController(title: Alert.scanningFailure.title, message: Alert.scanningFailure.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.scanningFailure.okButton, style: .default, handler: nil))
        
        return alert
    }
    
    //valid signature into QR code alert
    static var validSignatureAlert: UIAlertController {
        let alert = UIAlertController(title: Alert.validSignature.title, message: Alert.validSignature.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.validSignature.okButton, style: .default, handler: nil))
        
        return alert
    }
    
    //invalid signature into QR code alert
    static var inValidSignatureAlert: UIAlertController {
        let alert = UIAlertController(title: Alert.inValidSignature.title, message: Alert.inValidSignature.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.inValidSignature.okButton, style: .default, handler: nil))
        
        return alert
    }
    
    //invalid signature into QR code alert
    static var deviceSuppportFailedAlert: UIAlertController {
        let alert = UIAlertController(title: Alert.deviceSupportFailed.title, message: Alert.deviceSupportFailed.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.deviceSupportFailed.okButton, style: .default, handler: nil))
        
        return alert
    }
}
