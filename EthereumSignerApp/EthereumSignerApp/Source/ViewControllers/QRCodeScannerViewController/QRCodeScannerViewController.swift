//
//  QRCodeScannerViewController.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 22/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class QRCodeScannerViewController: UIViewController {
    @IBOutlet var scannerView: UIView! {
        didSet {
//            let scanner = GnosisQRScanner(frame: scannerView.bounds)
            let scanner = GnosisQRScanner(frame: scannerView.bounds, delegate: self)
            //scanner.delegate = self
            
            scannerView.addSubview(scanner)
            scannerView.bringSubviewToFront(scanner)
        }
    }
    
    private var message: String?
    
    var viewModel: QRCodeScannerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
    }
    
    func configureViewModel() {
        viewModel?.onValidSignature = { [weak self] in
            self?.present(UIAlertController.validSignatureAlert, animated: true, completion: nil)
        }
        
        viewModel?.onInvalidSignature = {  [weak self] in
            self?.present(UIAlertController.inValidSignatureAlert, animated: true, completion: nil)
        }
    }
}

extension QRCodeScannerViewController: GnosisViewController {
    static var storyboardIdentifier: String { return "QRCodeScannerViewController" }
}

extension QRCodeScannerViewController: GnosisQRScannerDelegate {
    func scanner(_ scanner: GnosisQRScanner, didScan result: String) {
        viewModel?.validate(signature: result)
    }
    
    func scanner(_ scanner: GnosisQRScanner, didFail error: Error) {
        self.present(UIAlertController.scanningFailedAlert, animated: true, completion: nil)
    }
}

