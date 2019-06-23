//
//  SetupViewController.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 18/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    // MARK: - IBOutlets
    
    /// Outlet for activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        //initially hide loader
        didSet { activityIndicator.isHidden = true }
    }
    
    //outlet for text field
    @IBOutlet weak var privateKeyTextField: UITextField! {
        didSet { UITextField.round(textField: privateKeyTextField) }
    }
    
    // MARK: - Properties
    
    /// private reference to balance, set once fetched
    private var balance: String?
    
    /// viewModel for the view
    var viewModel: SetupViewModel?
    
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check for setup to account screen segue
        if let identifier = segue.identifier, identifier == Segue.setupToAccount {
            // Get the new view controller using segue.destination.
            let navController: UINavigationController = segue.destination as! UINavigationController
            let accoutView: AccountViewController = navController.viewControllers.first as! AccountViewController
            
            //view model should be present
            guard let viewModel = viewModel else { return }
            
            //balance should be present
            guard let balance = balance else { return }
            
            //set destination view controller's view model
            accoutView.viewModel = AccountViewModel(serviceProvider: viewModel.etherServiceProvider, balance: balance)
        }
    }
    
    // MARK: - Methods

    /// method to setup the account
    ///
    /// - Parameter key: Private key of the account
    func setupAccount(forPrivateKey key: String) {
        //first show loader
        showLoader()

        do {
            //try initializing view model with private key
            try initializeViewModel(forPrivateKey: key)
        } catch {
            //hide loader
            self.hideLoader()
            
            //viewmodel can't be initialized with invalid key, show alert
            self.present(UIAlertController.invalidKeyAlert , animated: true, completion: nil)
        }
        
        
        //get balance of account
        viewModel?.getBalance()
}
    
    /// method to initialize ViewModel
    ///
    /// - Parameter key: private key of user account
    /// - Throws: exception if key is invalid
    func initializeViewModel(forPrivateKey key: String) throws {
            //create view model
            viewModel = try SetupViewModel(privateKey: key)
            
            //set success block of balance fetching
            viewModel!.onBalanceSuccess = { [weak self] (balance) in
                //hide loader
                self?.hideLoader()
                
                //go to account screen
                self?.balance = balance
                self?.performSegue(withIdentifier: Segue.setupToAccount, sender: self)
            }
            
            // set failure block of balance fetching
            viewModel!.onBalanceFailure = { [weak self] (error) in
                //hide loader
                self?.hideLoader()
                
                //show balance fetching failure alert
                self?.present(UIAlertController.balanceFetchAlert, animated: true, completion: nil)
            }
    }
}

// extension for methods to interact with activity indicator
extension SetupViewController {
    /// method to perform tasks while showing loader
    func showLoader() {
        //disable user interaction with view
        view.isUserInteractionEnabled = false
        
        //animate
        activityIndicator.startAnimating()
        
        //show
        activityIndicator.isHidden = false
        
        //should hide when stopped
        activityIndicator.hidesWhenStopped = true
    }
    
    /// method to perform tasks while hiding loader
    func hideLoader() {
        //stop activity indicator
        activityIndicator.stopAnimating()
        
        //enable user interaction with view
        view.isUserInteractionEnabled = true
    }
}

// Extension for TextField Delegate Methods
extension SetupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setupAccount(forPrivateKey: textField.text!)
        
        return true
    }
}
