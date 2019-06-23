//
//  VerificationViewModel.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 21/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit

class VerificationViewModel {
    ///ether service provider
    private(set) var etherServiceProvider: AbstractCryptoServiceProvider
    
    /// code block called on message verification
    var onMessageVerification: ((String) -> Void)?
    
    /// Init method
    ///
    /// - Parameter serviceProvider: service provider for verifying signature
    init(serviceProvider: AbstractCryptoServiceProvider) {
        //set service provider
        self.etherServiceProvider = serviceProvider
    }
    
    /// method called when Verify message button tapped
    ///
    /// - Parameter message: user message
    func verify(message: String) {
        //call message verification block
        onMessageVerification?(message)
    }
    
    /// method to tell when verify message button should be enabled
    ///
    /// - Parameter message: message being typed
    /// - Returns: true if button should be enabled, false otherwise
    func shouldEnableButton(for message: String?) -> Bool {
        guard let message = message else { return false }
        
        //enable button if message is not empty
        return !message.isEmpty
    }

}
