//
//  MockQRGeneratorFailure.swift
//  EthereumSignerAppTests
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import web3swift
@testable import EthereumSignerApp

class MockQRGeneratorFailure: QRGenerator {
    func generateQR(for string: String) throws -> UIImage { throw MockError.dummy }
}
