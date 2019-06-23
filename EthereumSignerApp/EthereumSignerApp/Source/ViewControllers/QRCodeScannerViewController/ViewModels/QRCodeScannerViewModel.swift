//
//  QRCodeScannerViewModel.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 22/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

struct QRCodeScannerViewModel {
    ///ether service provider
    private(set) var etherServiceProvider: AbstractCryptoServiceProvider
    
    /// user message to check in QRCode
    private(set) var message: String
    
    /// code block called on finding valid signature in QRCode
    var onValidSignature: (() -> Void)?
    
    /// code block on invalid on finding invalid signature in QRCode
    var onInvalidSignature: (() -> Void)?
    
    /// Init method
    ///
    /// - Parameters:
    ///   - message: user message to check into QRCode
    ///   - serviceProvider: ethereum service provider to validate signature
    init(message: String, serviceProvider: AbstractCryptoServiceProvider) {
        //set message
        self.message = message
        
        //set service provider
        self.etherServiceProvider = serviceProvider
    }
    
    /// method to validat signature
    ///
    /// - Parameter signature: signature found into QR code
    func validate(signature: String) {
        //we encoded signature's bytes into QRCode as comma separated string, now convert string back to bytes
        let bytesStringArray = signature.components(separatedBy: ",")

        var bytesArray: [UInt8] = [UInt8]()
        for element in bytesStringArray {
            let uInt = UInt8(element)
            guard let number = uInt else { break }
            
            bytesArray.append(number)
        }

        /*let bytesArray = bytesStringArray.map { (element) -> UInt8 in
            let uInt = UInt8(element)
            guard let number = uInt else { return }
            return number
        }*/
        
        if bytesArray.count != bytesStringArray.count {
            onInvalidSignature?()
        }
        
        //data from signature bytes
        let signatureData = Data(bytes: bytesArray)
    
        //validate message into signature data
        if etherServiceProvider.isValid(signature: signatureData, message: message) == true {
            //signature is valid
            onValidSignature?()
        } else {
            //signature is invalid
            onInvalidSignature?()
        }
    }
}
