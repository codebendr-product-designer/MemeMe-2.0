//
//  FontViewController.swift
//  MemeMe 1.0
//
//  Created by codebendr on 15/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class FontViewController: UIViewController {
    
    var fontFamilyNames = UIFont.familyNames
    var font = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func useButtonPressed(_ sender: Any) {
        if !font.isEmpty {
            NotificationCenter.default.post(name: .didChooseFontName, object: font)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: UIPickerViewDataSource
extension FontViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontFamilyNames.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}

//MARK: UIPickerViewDelegate
extension FontViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fontFamilyNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        font = fontFamilyNames[row]
    }
}
