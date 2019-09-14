//
//  Alert.swift
//  MemeMe 1.0
//
//  Created by codebendr on 13/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

struct Alerts {
    
    enum AlertType {
        case noCamera
        case noSource
    }
    
    static let DismissAlert = "Dismiss"
    
    //used internally to control error messages
    //returns a tuple of message and title
    private static func localized(_ type: AlertType) -> (title: String, message: String) {
        switch type {
        case .noCamera:
            return (title: "No Camera Found", message: "You don't seem to have a camera on this device.")
            case .noSource:
            return (title: "Unsupported Source Type", message: "The source type you choose is not available")
        }
    }
    
    static func show(type: AlertType) -> UIAlertController {
        let alert = UIAlertController(title: Alerts.localized(type).title, message: Alerts.localized(type).message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        return alert
        
    }
}
