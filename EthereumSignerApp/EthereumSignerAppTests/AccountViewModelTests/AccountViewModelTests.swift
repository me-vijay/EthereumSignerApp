//
//  AccountViewModel.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import XCTest
import web3swift
@testable import EthereumSignerApp

class AccountViewModelTests: XCTestCase {
    //keystore
    var keystore: PlainKeystore!
    
    //service provider
    var serviceProvider: EtherServiceProvider!
    
    //view model
    var accountViewModel: AccountViewModel!

    override func setUp() {
        //set data
        keystore = try! PlainKeystore(privateKey: TestConstants.privateKey)
        
        serviceProvider = EtherServiceProvider(keyStore: keystore)
        
        accountViewModel = AccountViewModel(serviceProvider: serviceProvider, balance: "")
    }

    override func tearDown() {
        keystore = nil
        serviceProvider = nil
        accountViewModel = nil
    }

    func test_Init_SetsCorrectServiceProvider() {
        //get service provider of view model
        let viewModelServiceProvider = accountViewModel.etherServiceProvider as! EtherServiceProvider
        
        //viewModelServiceProvider should be same as our service provider
        XCTAssertTrue(viewModelServiceProvider === serviceProvider, "Invalid service provider was set in init()")
    }
    
    func test_BalanceStringFormat_WhenBalanceIsEmpty() {
        //get balance string of view model
        let balance = accountViewModel.etherBalance
        
        //compare with valid string
        XCTAssertEqual(balance, "0 Ether", "Balance string is not valid with empty balance")
    }

    func test_BalanceStringFormat_WhenBalanceIsNotEmpty() {
        //set data
        let keystore = try! PlainKeystore(privateKey: TestConstants.privateKey)
        let serviceProvider = EtherServiceProvider(keyStore: keystore)
        let balance = "109.998"
        
        //create a different account model for this test
        let viewModel = AccountViewModel(serviceProvider: serviceProvider, balance: balance)
        
        //expected balance string
        let expectedBalance = balance + " Ether"
        
        //balance string of view model
        let viewModelBalance = viewModel.etherBalance
        
        //compare with valid string
        XCTAssertEqual(viewModelBalance, expectedBalance, "Balance string is not valid with empty balance")
    }

    func test_Address_IsCorrect() {
        //view model gives same address as in keystore
        XCTAssertEqual(accountViewModel.address, keystore.addresses.first!.address)
    }
}
