//
//  SignatureViewController.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 21/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {
    /// outlet for label showing user message
    @IBOutlet weak var userMessageLabel: UILabel!
    
    /// outlet for image showing QRCoee
    @IBOutlet weak var qrImageView: UIImageView!
    
    /// view model reference
    var viewModel: SignatureViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show data on screen
        showData()
    }
    
    /// method to show data on screen
    func showData() {
        guard let viewModel = viewModel else { return }
        
        //show user message
        userMessageLabel.text = viewModel.message
        
        //show QR Code
        qrImageView.image = viewModel.qrCodeImage
    }
}

// MARK: - GnosisViewController Methods
extension SignatureViewController: GnosisViewController {
    static var storyboardIdentifier: String { return "SignatureViewController" }
}
