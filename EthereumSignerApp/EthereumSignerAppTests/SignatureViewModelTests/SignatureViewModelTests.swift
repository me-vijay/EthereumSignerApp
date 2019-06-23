//
//  SignatureViewModelTests.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import XCTest
import web3swift
@testable import EthereumSignerApp

class SignatureViewModelTests: XCTestCase {    
    func test_Init_SetsCorrectImage() {
        //create an empty image
        let emptyImage = UIImage()
        
        //create view model
        let signatureViewModel = SignatureViewModel(message: "", qrCodeImage: emptyImage)
        
        //view model's image should be equal to empty image
        XCTAssertEqual(signatureViewModel.qrCodeImage, emptyImage, "Init doest not set correct image")
    }
    
    func test_Message_IsFormattedCorrect() {
        //original message
        let message = "test message"
        
        //formatted message
        let formattedMessage = "\"\(message)\""
        
        //create view model
        let signatureViewModel = SignatureViewModel(message: message, qrCodeImage: UIImage())

        //view model's message should be equal to formatted message
        XCTAssertEqual(signatureViewModel.message, formattedMessage, "Message format is in-correct")
    }
}
