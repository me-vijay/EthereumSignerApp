//
//  SigningiewModelTests.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import XCTest
import web3swift
@testable import EthereumSignerApp

class SigningiewModelTests: XCTestCase {
    
    func test_Init_SetsCorrectServiceProvider() {
        //set data
        let serviceProvider = MockServiceProviderSuccess() // EtherServiceProvider(keyStore: keystore)
        let signingViewModel = SigningViewModel(serviceProvider: serviceProvider)

        //get service provider of view model
        let viewModelServiceProvider = signingViewModel.etherServiceProvider as! MockServiceProviderSuccess
        
        //viewModelServiceProvider should be same as our service provider
        XCTAssertTrue(viewModelServiceProvider === serviceProvider, "Invalid service provider was set in init()")
    }
    
    /// method to generate mocked view model with different config for different tests
    ///
    /// - Parameters:
    ///   - serviceProviderSuccess: when true, mocks view model with MockServiceProviderSuccess, otherwise MockServiceProviderFailure
    ///   - qrGeneratorSuccess: when true, mocks view model with MockQRGeneratorSuccess, otherwise MockServiceProviderFailure
    /// - Returns: mocked SigningViewModel object
    private func mockedViewModelWith(serviceProviderSuccess: Bool, qrGeneratorSuccess: Bool) -> SigningViewModel {
        // create provider
        let provider: AbstractCryptoServiceProvider = (serviceProviderSuccess == true) ? MockServiceProviderSuccess() : MockServiceProviderFailure()
        
        //create view model
        let viewModel = SigningViewModel(serviceProvider: provider)
        
        // create QR Generator
        let qrGenerator: QRGenerator = (qrGeneratorSuccess == true) ? MockQRGeneratorSuccess() : MockQRGeneratorFailure()
        
        //set view model's QR generator
        viewModel.qrGenerator = qrGenerator
        
        return viewModel
    }

    func test_SignMessage_CallsSuccessBlockWithImage() {
        //mock with success provider and qr code generator
        let viewModel = mockedViewModelWith(serviceProviderSuccess: true, qrGeneratorSuccess: true)
        
        // set expectation
        let expectation = XCTestExpectation(description: "SignMessageSuccessBlock")
        
        //set success block
        viewModel.onSigningSuccess = { (image) in
            XCTAssertTrue(true)
            expectation.fulfill()
        }

        //set failure block
        viewModel.onSigningFailure = { (error) in
            //failure block should not be called
            XCTFail()
            expectation.fulfill()
        }

        //call method being tested
        viewModel.sign(message: "")
        
        //wait for expectation to fulfill
        wait(for: [expectation], timeout: 2)
    }

    func test_SignMessageCallsFailure_IfOnlyServiceProviderFails() {
        
        //mock with success qr code generator and failing provider
        let viewModel = mockedViewModelWith(serviceProviderSuccess: false, qrGeneratorSuccess: true)

        // set expectation
        let expectation = XCTestExpectation(description: "SignMessageCallsFailure")
        
        //set success block
        viewModel.onSigningSuccess = { (image) in
            //success block should not be called
            XCTFail()
            expectation.fulfill()
        }
     
        //set failure block
        viewModel.onSigningFailure = { (error) in
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        
        //call method being tested
        viewModel.sign(message: "test message")

        //wait for expectation to fulfill
        wait(for: [expectation], timeout: 2)
    }
    
    func test_SignMessageCallsFailure_IfOnlyQRGeneratorFails() {
        //mock with success provider and failure QR generator
        let viewModel = mockedViewModelWith(serviceProviderSuccess: true, qrGeneratorSuccess: false)

        // set expectation
        let expectation = XCTestExpectation(description: "SignMessageCallsFailure")
        
        //set success block
        viewModel.onSigningSuccess = { (image) in
            XCTFail()
            expectation.fulfill()
        }

        //set failure block
        viewModel.onSigningFailure = { (error) in
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        
        //call method being tested
        viewModel.sign(message: "test message")
        
        //wait for expectation to fulfill
        wait(for: [expectation], timeout: 2)
    }
    
    func test_SignMessageCallsFailure_WhenBothServiceProviderAndQRGeneratorFail() {
        // mock with failure provider and QR generator
        let viewModel = mockedViewModelWith(serviceProviderSuccess: false, qrGeneratorSuccess: false)

        // set expectation
        let expectation = XCTestExpectation(description: "SignMessageCallsFailure")
        
        //set success block
        viewModel.onSigningSuccess = { (image) in
            XCTFail()
            expectation.fulfill()
        }
       
        //set failure block
        viewModel.onSigningFailure = { (error) in
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        
        //call method being tested
        viewModel.sign(message: "test message")
        
        //wait for expectation to fulfill
        wait(for: [expectation], timeout: 2)
    }
    
    func test_ShouldEnableButton_ReturnsFalseForEmptyMessage() {
        //create view model
        let viewModel = SigningViewModel(serviceProvider: MockServiceProviderSuccess())
        
        //call method being tested
        let shouldEnable = viewModel.shouldEnableButton(for: "")
        
        //assert
        XCTAssertFalse(shouldEnable, "Button should be enable with empty message")
    }

    func test_ShouldEnableButton_ReturnsTrueForNonEmptyMessage() {
        //create view model
        let viewModel = SigningViewModel(serviceProvider: MockServiceProviderSuccess())
        
        //call method being tested
        let shouldEnable = viewModel.shouldEnableButton(for: "test message")
        
        //assert
        XCTAssertTrue(shouldEnable, "Button should be enable with empty message")
    }
}
