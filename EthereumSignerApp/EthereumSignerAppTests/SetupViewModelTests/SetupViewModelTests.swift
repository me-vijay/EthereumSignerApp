//
//  SetupViewModelTests.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import XCTest
@testable import EthereumSignerApp

class SetupViewModelTests: XCTestCase {

    func test_Init_SucceedsWithValidKey() {
        var viewModel: SetupViewModel?
        do {
            //create view model with a valid key
            viewModel = try SetupViewModel(privateKey: TestConstants.privateKey)
        } catch  {
            //if exception occurred, test should fail
            XCTFail()
        }
        
        //view model should not be nil
        XCTAssertNotNil(viewModel, "SetupViewModel failed initiliazation with valid private key")
    }
    
    func test_Init_FailsWithAnError() {
        do {
            //creating view model with an invalid key
            _ = try SetupViewModel(privateKey: "01F9D86C0FD91FE8E1A5DFB09DDDA848DB933A92F4A096E86366618")
            
            //test should fail if no exception occurred
            XCTFail()
        } catch  {
        //exceptions occurrs, error should be present
          XCTAssertNotNil(error, "SetupViewModel initiliazation should fail with error")
        }
    }
}
