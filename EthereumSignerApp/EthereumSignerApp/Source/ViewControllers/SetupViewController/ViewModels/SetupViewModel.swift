//
//  SetupViewModel.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 18/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import web3swift

class SetupViewModel {
    // MARK: - Private Properties
    
    ///keystore to hold private key
    ///not being used, it's to facilitate the lazy creation of ether service provider
    private let keystore: PlainKeystore
    
    ///service provider with rinkeby network as default
    private(set) lazy var etherServiceProvider = EtherServiceProvider(keyStore: keystore)

    // MARK: - Public Properties
    
    /// called on success in fetching balance
    var onBalanceSuccess: ((String) -> Void)?
    
    /// called on failure in fetching balance
    var onBalanceFailure: ((Error) -> Void)?
        
    // MARK: - Initializers
    
    /// create object with private key
    ///
    /// - Parameter privateKey: privateKey in String
    /// - Throws: PrivateKeyError.invalidPrivateKeyError if unable to create keystore
    init(privateKey: String) throws {
        do {
            //create keystore with provided private key
            keystore = try PlainKeystore.init(privateKey: privateKey)
        } catch {
            //some error occurred creating the keystore
            throw PrivateKeyError.invalidPrivateKeyError
        }
    }
    
    // MARK: - Methods
    
    /// fetches Ethereum balance using Ether Network
    func getBalance() {        
        //fetch using network client
        etherServiceProvider.fetchBalance {[weak self] (balance, error) in
            if error == nil {
                //no error, call success closure
                self?.onBalanceSuccess?(balance!)
            } else {
                //error occurred, call failure closure
                self?.onBalanceFailure?(error!)
            }
        }//end completion closure
    }
}

/// Enum for error occured while creating view model with a private key
public enum PrivateKeyError: Error {
    /// invalid key error
    case invalidPrivateKeyError
    
    /// computed property for description of the error type
    public var localizedDescription: String {
        switch self {
        case .invalidPrivateKeyError:
            return "cannot verify private key"
        }
    }
}
