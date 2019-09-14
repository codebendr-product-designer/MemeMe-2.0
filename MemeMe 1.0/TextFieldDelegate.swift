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
        return true
    }
}
