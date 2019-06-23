//
//  UITextFieldExtension.swift
//  EthereumSignerApp
//
//  Created by Vijay Kumar on 22/06/2019.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

extension UITextField {
    class func round(textField: UITextField) {
        //set style to rounded
        textField.borderStyle = .roundedRect
        
        // set empty view on left, to start text by some offset
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
}
