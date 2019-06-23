//
//  SignatureViewModel.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 21/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit

struct SignatureViewModel {
    /// message provided by user
    private var userMessage: String
    
    ///QRCode image
    private(set) var qrCodeImage: UIImage
    
    
    /// computed property for formatted message to be shown
    var message: String  {
        return "\"\(userMessage)\""
    }
    
    /// Init Method
    ///
    /// - Parameters:
    ///   - message: <#message description#>
    ///   - qrCodeImage: <#qrCodeImage description#>
    init(message: String, qrCodeImage: UIImage) {
        //set user message
        self.userMessage = message
        
        //set QRCode image
        self.qrCodeImage = qrCodeImage
    }
}
