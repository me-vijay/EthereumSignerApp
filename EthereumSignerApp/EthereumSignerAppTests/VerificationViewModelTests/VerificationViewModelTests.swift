//
//  VerificationViewModelTests.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import XCTest
import web3swift
@testable import EthereumSignerApp

class VerificationViewModelTests: XCTestCase {
    
    func test_Init_SetsCorrectServiceProvider() {
        //set data
        let serviceProvider = MockServiceProviderSuccess()
        let verificationViewModel = VerificationViewModel(serviceProvider: serviceProvider)
        
        //get service provider of view model
        let viewModelServiceProvider = verificationViewModel.etherServiceProvider as! MockServiceProviderSuccess
        
        //viewModelServiceProvider should be same as our service provider
        XCTAssertTrue(viewModelServiceProvider === serviceProvider, "Invalid service provider was set in init()")
    }
    
    func test_VerifyMessage_CallsMessageVerificationBlockWithOriginalMessage() {
        //create view model
        let verificationViewModel = VerificationViewModel(serviceProvider: MockServiceProviderSuccess())
        
        //test message
        let originalMessage = "test message"
        
        //set expectation
        let expectation = XCTestExpectation(description: "SameMessageVerification")
        
        //set message verification block
        verificationViewModel.onMessageVerification = { (message) in
            //assert
            XCTAssertEqual(message, originalMessage, "Message must not be modified")
            
            //expectation is fulfilled
            expectation.fulfill()
        }
        
        //call verify message
        verificationViewModel.verify(message: originalMessage)
        
        //wait for expectation to get fulfilled
        wait(for: [expectation], timeout: 2)
    }
}
