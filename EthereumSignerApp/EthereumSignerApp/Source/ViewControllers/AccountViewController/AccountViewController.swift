//
//  AcountViewController.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 20/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    // MARK: - IBOutlets
    /// outlet for label showing address
    @IBOutlet weak var addressLabel: UILabel!
    
    
    /// outlet for label showing balance
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: - Properties
    /// view model
    var viewModel: AccountViewModel?
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set view title
        self.title = "Account"
        
        //show data on screen
        configureData()
    }
    
    // MARK: - Methods
    /// method to show data on screen from view model
    func configureData() {
        //view model should not be nil
        guard let viewModel = viewModel else {
            return
        }
        
        //show address
        self.addressLabel.text = viewModel.address
        
        //show balance
        self.balanceLabel.text = viewModel.etherBalance
    }

    /// method to show signing screen
    func showSigningViewController() {
        guard let viewModel = viewModel else { return }
        
        //creat Signing controller
        let signingViewController = UIStoryboard.signingViewController
        
        //create signing view model
        let signingViewModel = SigningViewModel(serviceProvider: viewModel.etherServiceProvider)
        
        // set signing controller's view model
        signingViewController.viewModel = signingViewModel
        
        //push signing controller on nav stack
        self.navigationController?.pushViewController(signingViewController, animated: true)
    }
    
    /// method to show verification screen
    func showVerificationViewController() {
        guard let viewModel = viewModel else { return }

        //creat Verification controller
        let verificationViewController = UIStoryboard.verificationViewController
        
        //create Verification view model
        let verificationViewModel = VerificationViewModel(serviceProvider: viewModel.etherServiceProvider)
        
        // set verification controller's view model
        verificationViewController.viewModel = verificationViewModel
        
        //push verification controller on nav stack
        self.navigationController?.pushViewController(verificationViewController, animated: true)
    }

    @IBAction func signButtonTapped(_ sender: Any) {
        showSigningViewController()
    }
    
    @IBAction func verifyButtonTapped(_ sender: Any) {
        showVerificationViewController()
    }
}
