//
//  GnosisQRGenerator.swift
//  GnosisQR
//
//  Created by Vijay Kumar on 21/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreImage
import UIKit

class GnosisQRGenerator: QRGenerator {
    private lazy var filter = CIFilter(name: QRFilter.name)
    
    init() {}

    func generateQR(for string: String) throws -> UIImage {
        guard let filter = filter else { throw QRGeneratorError.failedFilterInitialization }
        
        guard let data = string.data(using: .isoLatin1, allowLossyConversion: false) else { throw QRGeneratorError.failedMessageCoversion }
        
        filter.setValue(data, forKey: QRFilter.Keys.message)
        filter.setValue(QRFilter.CorrectionLevel.highQuality, forKey: QRFilter.Keys.correctionLevel)
        
        guard let ciImage = filter.outputImage else { throw QRGeneratorError.failedQRImageCreation }
        
        return UIImage(ciImage: ciImage)
    }
}

private enum QRFilter {
    static let name = "CIQRCodeGenerator"
    
    enum Keys {
        static let message = "inputMessage"
        static let correctionLevel = "inputCorrectionLevel"
    }
    
    enum CorrectionLevel {
        static let low = "L" //7% error resilience
        static let medium = "M" //15% error resilience
        static let quality = "Q" //25% error resilience
        static let highQuality = "H" //30% error resilience
    }
}

enum QRGeneratorError: Error {
    case failedFilterInitialization
    case failedMessageCoversion
    case failedQRImageCreation
    
    func description() -> String {
        switch self {
        case .failedFilterInitialization:
            return "Could not initialize CIFilter named CIQRCodeGenerator"
        case .failedMessageCoversion:
            return "Could not covert message to Data using format ISOLatin1"
        case .failedQRImageCreation:
            return "CIFilter failed creating image for QRCode"
        }
    }
}
