//
//  AbstractEtherServiceProvider.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 20/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import web3swift

/// handler for balance fetching completion
/// - String: if fetched it's balance in string value otherwise nil
/// - Error: error if occurred or nil otherwise
public typealias completionHandlerBalance = ((String?, Error?) -> ())

public protocol AbstractCryptoServiceProvider {
    /// Web3 object to interact with ether network
    var web3Client: Web3 { get }

    //keystore to hold private key
    var keystore: PlainKeystore { get }
    
    /// method to fetch Ether balance from address in keystore(data member above)
    ///
    /// - Parameters:
    ///   - completion: completion handler called on main thread, upon success or failure
    func fetchBalance(completion: @escaping completionHandlerBalance)
    
    /// method to generate signature
    ///
    /// - Parameter message: message to encode into signature
    /// - Returns: generated signature as Data
    /// - Throws: throws Error: SigningError if any error occurrs while signing
    func signature(of message:String) throws -> Data

    /// method to validate if a signature has the message signed by user of this keystore
    ///
    /// - Parameters:
    ///   - signature: signed signature
    ///   - message: message to verify inside signature
    /// - Returns: true if the signature has message that was signed by this user, false otherwise
    func isValid(signature: Data, message: String) -> Bool
}
