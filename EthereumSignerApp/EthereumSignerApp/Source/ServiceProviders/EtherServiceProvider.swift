//
//  EtherServiceProvider.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 20/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import web3swift

class EtherServiceProvider: AbstractCryptoServiceProvider {
    
    /// - Protocol conforming data members
    
    /// Web3 object to interact with ether network
    private(set) var web3Client: Web3
    
    //keystore to hold private key
    private(set) var keystore: PlainKeystore

    // MARK: - Initializers
    
    /// initializer
    ///
    /// - Parameters:
    ///   - keyStore: keystore having user private key
    ///   - network: network type (rinkeby, ropsten, mainnet, kovan), used to initialize web3
    ///   - accessToken: ProjectID of project (at https://infura.io), used to initialize web3
    init(keyStore: PlainKeystore, network: NetworkId = .rinkeby, accessToken: String = AppConfig.infuraProjectID) {
        //set keystore
        self.keystore = keyStore
        
        //create web3
        self.web3Client = Web3.init(infura: network, accessToken: accessToken)
    }

    /// initializer
    ///
    /// - Parameters:
    ///   - keyStore: keystore having user private key
    ///   - web3: web3 object to interact with ethereum test network
    init(keyStore: PlainKeystore, web3: Web3 ) {
        //set keystore
        self.keystore = keyStore
        
        //set web3 object
        self.web3Client = web3
    }

    // MARK: - Methods
    
    /// method to fetch Ether balance
    ///
    /// - Parameters:
    ///   - address: address to fetch balance from
    ///   - completion: completion handler called on main thread, upon success or failure
    func fetchBalance(completion: @escaping completionHandlerBalance) {
        //get account address
        let address = self.keystore.addresses.first!

        //getBalance is synchronous, so start background thread
        DispatchQueue.global().async {
            do {
                //get ether balance from given address
                let balanceAsBigUInt = try self.web3Client.eth.getBalance(address: address)
                
                //received balance is in BigUInt and Wei unit, convert to String and Ethers unit
                let balanceAsString = balanceAsBigUInt.objc.string(units: .eth)
                
                //call completion on main thread, with balance in Ethers
                DispatchQueue.main.async {
                    completion(balanceAsString, nil)
                }
            } catch {
                //call completion on main thread, with error
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }//end catch
        }//end global dispatch
    }
    
    /// method to generate signature
    ///
    /// - Parameter message: message to encode into signature
    /// - Returns: generated signature as Data
    /// - Throws: throws Error: SigningError if any error occurrs while signing
    func signature(of message:String) throws -> Data {
        web3Client.addKeystoreManager(KeystoreManager([keystore]))
        
        guard let messageData = message.data(using: .utf8) else { throw SigningError.failedMessageConversion }
        
        let signature = try web3Client.personal.signPersonalMessage(message: messageData,
                                                                    from: keystore.addresses.first!)
        return signature
    }

    /// method to validate if a signature has the message signed by user of this keystore
    ///
    /// - Parameters:
    ///   - signature: signed signature
    ///   - message: message to verify inside signature
    /// - Returns: true if the signature has message that was signed by this user, false otherwise
    func isValid(signature: Data, message: String) -> Bool {
        var isValid = false
        guard let messageData = message.data(using: .utf8) else { return isValid }
        
        do {
            let signerAddress = try web3Client.personal.ecrecover(personalMessage: messageData, signature: signature)
            let userAddress = keystore.addresses.first!
            
            isValid = userAddress == signerAddress
        } catch  {
            
        }
        return isValid
    }
}
