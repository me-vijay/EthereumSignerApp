//
//  VerificationViewController.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 20/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {
    /// Outlet for message text field
    @IBOutlet weak var messageTextField: UITextField! {
        didSet {
            //make textfield round
            UITextField.round(textField: messageTextField)
        }
    }

    /// Outlet for Verifymessage button
    @IBOutlet weak var verifyMessageButton: UIButton! {
        didSet {
            //button should be disabled initially
            verifyMessageButton.isEnabled = false
        }
    }

    /// message of user
    private var message: String?
    
    /// view model reference
    var viewModel: VerificationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set view title
        self.title = "Verification"
        
        //configure view model
        configureViewModel()
    }
    
    /// method to set view model properties
    func configureViewModel() {
        //view model should not be nil
        guard let viewModel = viewModel else { return }
        
        //set view model's message verification block
        viewModel.onMessageVerification = { [weak self] (msg) in
            self?.showScanner()
        }
    }
    
    /// IBAction method called when user is typing in message textfield
    @IBAction func textFieldDidChange(_ sender: Any) {
        //get textfield
        let textField: UITextField = sender as! UITextField
        
        //view model should not be nil
        guard let viewModel = viewModel else { return }
        
        //set button enabled state
        verifyMessageButton.isEnabled = viewModel.shouldEnableButton(for: textField.text)
    }

    /// IBAction method called when user taps on Verfiy message button
    @IBAction func verifyMessageTapped(_ sender: Any) {
        //using force unwrap because sign button is enabled only when textfield has some text
        message = messageTextField.text!
        
        //verify message
        viewModel?.verify(message: message!)
    }

    
    /// method to show scanner screen
    func showScanner() {
        //create scanning controller instance
        let qrCodeScannerViewController: QRCodeScannerViewController = UIStoryboard.qrCodeScannerViewController
        
        //set view model
        qrCodeScannerViewController.viewModel =  QRCodeScannerViewModel(message:self.message!,
                                                                        serviceProvider: (viewModel!.etherServiceProvider))
        
        //push on nav stack
        self.navigationController?.pushViewController(qrCodeScannerViewController, animated: true)
    }
}


// MARK: - GnosisViewController Methods
extension VerificationViewController: GnosisViewController {
    static var storyboardIdentifier: String { return "VerificationViewController" }
}

// MARK: - GnosisQRScannerDelegate Methods
//extension VerificationViewController: GnosisQRScannerDelegate {
//    //scanning success delegate
//    func scanner(_ scanner: GnosisQRScanner, didScan result: String) {
//        self.present(UIAlertController.validSignatureAlert, animated: true, completion: nil)
//    }
//    
//    //scanning failure delegate
//    func scanner(_ scanner: GnosisQRScanner, didFail error: Error) {
//        self.present(UIAlertController.scanningFailedAlert, animated: true, completion: nil)
//    }
//}

// Extension for TextField Delegate Methods
extension VerificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
