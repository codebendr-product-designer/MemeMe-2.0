//
//  TextFieldDelegate.swift
//  MemeMe 1.0
//
//  Created by codebendr on 14/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if var text = textField.text, text.isEmpty {
            text = "TOP"
        }
        print("textFieldShouldReturn")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        textField.text = ""
        if var text = textField.text {
            print(text)
            if text == "TOP" || text == "BOTTOM" {
                text = ""
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldEndBeginEditing")
        textField.text = ""
        if var text = textField.text {
            print(text)
            if text == "TOP" || text == "BOTTOM" {
                text = ""
            }
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard var text = textField.text else {
            return
        }
        
        print("shouldChangeCharactersIn")
        
        return true
    }
}
