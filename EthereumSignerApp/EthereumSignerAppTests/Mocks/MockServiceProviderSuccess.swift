//
//  MockServiceProvider.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import web3swift
@testable import EthereumSignerApp

class MockServiceProviderSuccess: AbstractCryptoServiceProvider {
    var web3Client: Web3 { return Web3(infura: .rinkeby) }
    var keystore: PlainKeystore { return try! PlainKeystore(privateKey: TestConstants.privateKey) }
    
    func fetchBalance(completion: @escaping completionHandlerBalance) { completion("", nil) }
    
    func signature(of message:String) throws -> Data { return Data() }
    
    func isValid(signature: Data, message: String) -> Bool { return true }
}
