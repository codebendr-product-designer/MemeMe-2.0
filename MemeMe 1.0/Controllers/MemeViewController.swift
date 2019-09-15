//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by codebendr on 12/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnCamera: PickerImageButton!
    @IBOutlet weak var btnCameraRoll: PickerImageButton!
    @IBOutlet weak var txtTop: UITextField!
    @IBOutlet weak var txtBottom: UITextField!
    
    let txtDefault = "TEXT GOES HERE"
    let txtEmpty = ""
    var defaultTextAttributes: [NSAttributedString.Key: Any] {
        
        //lets center text because IB text is not working
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .center
        
        return [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "impact", size: 40)!,
            NSAttributedString.Key.strokeWidth: -4.0,
            NSAttributedString.Key.paragraphStyle: titleParagraphStyle
        ]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboardWhenTappedAround()
        
        btnCamera.sourceType = .camera
        btnCameraRoll.sourceType = .photoLibrary
        
        //  txtTop.placeholder = "TOP"
        txtTop.delegate = self
        txtTop.defaultTextAttributes = defaultTextAttributes
        
        //   txtBottom.placeholder = "BOTTOM"
        txtBottom.delegate = self
        txtBottom.defaultTextAttributes = defaultTextAttributes
        
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
    
    func configureUI (isShow: Bool) {
        
    }
    
    func generateMemedImage() -> UIImage {
        
        navigationController?.setToolbarHidden(true, animated: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navigationController?.setToolbarHidden(false, animated: true)
        
        return memedImage
    }
    
    @IBAction func shareButtonPressed() {
        
        if txtTop.text == txtDefault && txtBottom.text == txtDefault {
            
            let alert = Alerts.show(type: .noText)
            present(alert, animated: true, completion: nil)
            
        } else {
            
            let memedImage = generateMemedImage()
            let meme = Meme(topText: txtTop.text!, bottomText: txtBottom.text!, originalImage: img.image!, memedImage: memedImage)
            
            shareImage(image: meme.memedImage)
        }
        
    }
    
    func shareImage(image: UIImage) {
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            
            activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            
            if completed {
                self.dismiss(animated: true, completion: nil)
                
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            self.img.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}



