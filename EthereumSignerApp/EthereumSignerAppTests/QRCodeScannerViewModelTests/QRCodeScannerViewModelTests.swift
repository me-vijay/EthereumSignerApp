//
//  QRCodeScannerViewModelTests.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import XCTest
import web3swift
@testable import EthereumSignerApp

class QRCodeScannerViewModelTests: XCTestCase {
    func test_Init_SetsCorrectServiceProvider() {
        //set data
        let serviceProvider = MockServiceProviderSuccess()
        let qrCodeScannerViewModel = QRCodeScannerViewModel(message: "", serviceProvider: serviceProvider)
        
        //get service provider of view model
        let viewModelServiceProvider = qrCodeScannerViewModel.etherServiceProvider as! MockServiceProviderSuccess
        
        //viewModelServiceProvider should be same as our service provider
        XCTAssertTrue(viewModelServiceProvider === serviceProvider, "Invalid service provider was set in init()")
    }
    
    func test_Init_SetsCorrectMessage() {
        //set data
        let originalMessage = "test message"
        let serviceProvider = MockServiceProviderSuccess()
        let qrCodeScannerViewModel = QRCodeScannerViewModel(message: originalMessage, serviceProvider: serviceProvider)
        
        //viewModel message should be same as original message
        XCTAssertEqual(qrCodeScannerViewModel.message, originalMessage, "Init does not set correct message")
    }

    func test_ValidateMessage_CallsValidBlock() {
        //mock success service
        let serviceProvider = MockServiceProviderSuccess()
        var qrCodeScannerViewModel = QRCodeScannerViewModel(message: "", serviceProvider: serviceProvider)

        //set expectation
        let expectation = XCTestExpectation(description: "ValidSignatureBlockVerification")

        //set success block
        qrCodeScannerViewModel.onValidSignature = {
            expectation.fulfill()
        }
        
        //cal
        qrCodeScannerViewModel.validate(signature: "")

        //wait for expectation to get fulfilled
        wait(for: [expectation], timeout: 2)
    }

    func test_ValidateMessage_CallsInvalidBlock() {
        //mock failure service
        let serviceProvider = MockServiceProviderFailure()
        var qrCodeScannerViewModel = QRCodeScannerViewModel(message: "", serviceProvider: serviceProvider)
        
        //set expectation
        let expectation = XCTestExpectation(description: "InvalidSignatureBlockVerification")
        
        //set success block
        qrCodeScannerViewModel.onInvalidSignature = {
            expectation.fulfill()
        }
        
        //cal
        qrCodeScannerViewModel.validate(signature: "")
        
        //wait for expectation to get fulfilled
        wait(for: [expectation], timeout: 2)
    }
}
