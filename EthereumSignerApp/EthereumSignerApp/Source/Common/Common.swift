//
//  Common.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 22/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

enum SigningError: Error {
    case failedMessageConversion
    
    func description() -> String {
        switch self {
        case .failedMessageConversion:
            return "Could not covert message to Data using format UTF8"
        }
    }
}
