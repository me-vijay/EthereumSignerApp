//
//  QRGenerator.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 23/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

protocol QRGenerator {
    func generateQR(for string: String) throws -> UIImage
}
