//
//  MemeViewController+Notifications.swift
//  MemeMe 1.0
//
//  Created by codebendr on 15/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

extension EditMemeViewController {
    
    func subscribeToNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFonts(_:)), name: .didChooseFontName, object: nil)
        
    }
    
    func unsubscribeFromNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .didChooseFontName, object: nil)
    }
    
    @objc func updateFonts(_ notification: NSNotification){
        if let font = notification.object as? String {
            txtTop.font = UIFont(name: font, size: 40)!
            txtBottom.font = UIFont(name: font, size: 40)!
        }
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if txtBottom.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}

extension Notification.Name {
    static let didChooseFontName = Notification.Name("didChooseFontName")
}
