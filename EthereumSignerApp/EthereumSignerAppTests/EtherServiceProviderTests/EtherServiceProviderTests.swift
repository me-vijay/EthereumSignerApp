//
//  EtherServiceProviderTests.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 22/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import XCTest
import web3swift
@testable import EthereumSignerApp

class EtherServiceProviderTests: XCTestCase {
    var keystore: PlainKeystore!
    var serviceProvider: EtherServiceProvider!
    
    override func setUp() {
        //set keystore with key of a test account
        keystore = try! PlainKeystore.init(privateKey: TestConstants.privateKey)
        
        //set service provider
        serviceProvider = EtherServiceProvider(keyStore: keystore)
    }
    
    override func tearDown() {
        keystore = nil
        serviceProvider = nil
    }
    
    func test_Init_SetsCorrectKeystore() {
        XCTAssertTrue(serviceProvider.keystore === keystore, "keystore of service provider is invalid")
    }
    
    func test_Init_SetsCorrectKeystore_AndWeb3() {
        let web3 = Web3(infura: .rinkeby, accessToken: "")
        let localServiceProvider = EtherServiceProvider(keyStore: keystore, web3: web3)
        
        XCTAssertTrue(localServiceProvider.keystore === keystore, "Keystore of service provider is invalid")
        XCTAssertTrue(localServiceProvider.web3Client === web3, "Web3 of service provider is invalid")
    }
    
    func test_fetchBalance_CallsCompletion() {
        let expectation = XCTestExpectation(description: "CompletionCalledExpectation")
        
        serviceProvider.fetchBalance { (balance, error) in
            expectation .fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
    
    func test_fetchBalance_CallsCompletionWithBalanceOrError() {
        let expectation = XCTestExpectation(description: "CompletionCalledExpectation")
        
        serviceProvider.fetchBalance { (balance, error) in
            XCTAssertTrue(balance != nil || error != nil)
            expectation .fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }

}
