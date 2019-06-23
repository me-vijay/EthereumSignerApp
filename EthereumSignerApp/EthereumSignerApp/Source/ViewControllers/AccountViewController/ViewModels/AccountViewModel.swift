//
//  AccountViewModel.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 20/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

struct AccountViewModel {
    ///ether service provider
    private(set) var etherServiceProvider: AbstractCryptoServiceProvider
    
    ///balance in ethers
    private(set) var etherBalance: String
    
    //address of the account against private key
    var address: String { return etherServiceProvider.keystore.addresses.first!.address }
    
    /// initializer
    ///
    /// - Parameters:
    ///   - serviceProvider: service provider for ethereum
    ///   - balance: balance in Ethers
    init(serviceProvider:AbstractCryptoServiceProvider, balance: String) {
        //set service provider
        self.etherServiceProvider = serviceProvider
        
        //if balance has whitespace only, set it to zero
        let bal = (balance.trimmingCharacters(in: CharacterSet.whitespaces) == "") ? "0" : balance
        
        // set balance property
        self.etherBalance = "\(bal) Ether"
    }
}
