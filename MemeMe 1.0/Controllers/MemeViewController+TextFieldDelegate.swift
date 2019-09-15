//
//  TextFieldDelegate.swift
//  MemeMe 1.0
//
//  Created by codebendr on 14/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == txtDefault {
            textField.text = txtEmpty
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text?.isEmpty ?? true {
            textField.text = txtDefault
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var text = textField.text as NSString?
        text = text!.replacingCharacters(in: range, with: string) as NSString?
        
        //force capitalization for copied test
        textField.text = text?.uppercased
        
        return false
    }
}
