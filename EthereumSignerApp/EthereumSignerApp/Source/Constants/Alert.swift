//
//  Alerts.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 20/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

enum Alert {
    //invalid key
    enum invalidKey {
        public static let (title, message, okButton) = ("Invalid Private Key",
                                                        "Please provide a correct key",
                                                        "OK")
    }
    
    //balance fetch fail
    enum balanceFetchFailure {
        public static let (title, message, okButton) = ("Unable to fetch balance at this time",
                                                        "Please try later",
                                                        "OK")
    }
    
    //message signing fail
    enum signingFailure {
        public static let (title, message, okButton) = ("Signing failed",
                                                        "Please try later",
                                                        "OK")
    }
    
    //QR code scanning fail
    enum scanningFailure {
        public static let (title, message, okButton) = ("Scanning failed", "", "OK")
    }

    //valid signature in QRCode
    enum validSignature {
        public static let (title, message, okButton) = ("Signature is valid", "", "OK")
    }

    //invalid signature in QRCode
    enum inValidSignature {
        public static let (title, message, okButton) = ("Invalid signature", "", "OK")
    }

    //Device not supported for scanning
    enum deviceSupportFailed {
        public static let (title, message, okButton) = ("Device not supported", "", "OK")
    }

}
