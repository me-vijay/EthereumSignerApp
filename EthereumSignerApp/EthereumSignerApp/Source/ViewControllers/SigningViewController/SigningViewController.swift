//
//  SigningViewController.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 20/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit
//import GnosisQR

class SigningViewController: UIViewController {
    
    /// Outlet for message text field
    @IBOutlet weak var messageTextField: UITextField! {
        didSet {
            //make textfield round
            UITextField.round(textField: messageTextField)            
        }
    }
    
    /// Outlet for Sign message button
    @IBOutlet weak var signMessageButton: UIButton! { //should be disabled initially
        didSet { signMessageButton.isEnabled = false }
    }
    
    /// message of user
    private var message: String?
    
    /// view model reference
    var viewModel: SigningViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set view title
        self.title = "Signing"
        
        //configure view model
        configureViewModel()
    }
    
    /// method to set view model properties
    func configureViewModel () {
        //view model should not be nil
        guard let viewModel = viewModel else { return }
        
        //set view model's success block
        viewModel.onSigningSuccess = { [weak self] (qrImage) in
            if let message = self?.message {
                //show signature screen
                self?.showSignatureView(message: message, qrImage: qrImage)
            }
        }
        
        //set view model's failure block
        viewModel.onSigningFailure = { [weak self] (error) in
            //show alert
            self?.present(UIAlertController.signingFailedAlert, animated: true, completion: nil)
        }
    }
    
    /// method to show Signature screen
    ///
    /// - Parameters:
    ///   - message: message of user
    ///   - qrImage: QR Image of signature
    func showSignatureView(message: String, qrImage: UIImage) {
        //create view model of Signature screen
        let signatureViewModel = SignatureViewModel(message: message, qrCodeImage: qrImage)
        
        //create controller
        let signatureViewController: SignatureViewController = UIStoryboard.signatureViewController
     
        //set controller's view model
        signatureViewController.viewModel = signatureViewModel
        
        //push contoller on navigation stack
        self.navigationController?.pushViewController(signatureViewController, animated: true)
    }
    
    /// IBAction method called when user taps on Sign message button
    @IBAction func signMessageTapped(_ sender: Any) {
        //using force unwrap because sign button is enabled only when textfield has some text
        message = messageTextField.text!
        
        //sign the message
        viewModel?.sign(message: message!)
    }
    
    /// IBAction method called when user is typing in message textfield
    @IBAction func textFieldDidChange(_ sender: Any) {
        //get textfield
        let textField: UITextField = sender as! UITextField
        
        //view model should not be nil
        guard let viewModel = viewModel else { return }
        
        //set button enabled state
        signMessageButton.isEnabled = viewModel.shouldEnableButton(for: textField.text)
    }
}

// MARK: - GnosisViewController Methods
extension SigningViewController: GnosisViewController {
    static var storyboardIdentifier: String { return "SigningViewController" }
}

// Extension for TextField Delegate Methods
extension SigningViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
