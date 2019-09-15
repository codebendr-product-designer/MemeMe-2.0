//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by codebendr on 12/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet weak var imgMeme: UIImageView!
    @IBOutlet weak var btnCamera: PickerImageButton!
    @IBOutlet weak var btnCameraRoll: PickerImageButton!
    @IBOutlet weak var txtTop: UITextField!
    @IBOutlet weak var txtBottom: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       super.hideKeyboardWhenTappedAround()
        
        btnCamera.sourceType = .camera
        btnCameraRoll.sourceType = .photoLibrary
        
        let textFieldDelegate = TextFieldDelegate()
        txtTop.placeholder = "TOP"
        txtTop.delegate = textFieldDelegate
        txtBottom.placeholder = "BOTTOM"
        txtBottom.delegate = textFieldDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickImageFromSource(_ sender: PickerImageButton) {

        let imagePicker = UIImagePickerController()

        switch sender.sourceType {
        case .camera:
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                let alert = Alerts.show(type: .noCamera)
                present(alert, animated: true, completion: nil)
                sender.isEnabled = false
                return
            }
            imagePicker.sourceType = .camera
            
        case .photoLibrary :
            imagePicker.sourceType = .photoLibrary
            
        default :
            let alert = Alerts.show(type: .noSource)
            present(alert, animated: true, completion: nil)
            return
        }
        
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
 
}

//MARK: UIImagePickerControllerDelegate
extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            self.imgMeme.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}



