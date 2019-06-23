//
//  DataExtension.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 22/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

extension Data {
    /// gives string of Data bytes
    ///
    /// - Parameter separatedBy: separator between two bytes
    /// - Returns: string of Data bytes separated by specified separator
    func byteString(separatedBy: String = ",") -> String {
        let bytes = self.bytes
        
        let bytesInString = bytes.reduce("") { (result, next) -> String in
            if result.isEmpty { return String(next) }
            else { return result + separatedBy + String(next) }
        }
        
        return bytesInString
    }
}
