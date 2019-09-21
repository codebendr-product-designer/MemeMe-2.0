//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by codebendr on 12/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class EditMemeViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnCamera: PickerImageButton!
    @IBOutlet weak var btnCameraRoll: PickerImageButton!
    @IBOutlet weak var txtTop: UITextField!
    @IBOutlet weak var txtBottom: UITextField!
    @IBOutlet weak var toolBarBottom: UIToolbar!
    
    let txtDefault = "TEXT GOES HERE"
    let txtEmpty = ""
    var meme: Meme?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meme = meme {
            txtTop.text = meme.topText
            txtBottom.text = meme.bottomText
            img.image = meme.originalImage
        }
        
        btnCamera.sourceType = .camera
        btnCameraRoll.sourceType = .photoLibrary
        
        configureTextField(txtTop)
        configureTextField(txtBottom)
        
        navigationItem.leftItemsSupplementBackButton = true
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      tabBarController?.tabBar.isHidden = true
        subscribeToNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    tabBarController?.tabBar.isHidden = false
        unsubscribeFromNotifications()
    }
    
    @IBAction func eraseMemeButtonPressed(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let alert =  Alerts.show(type: .eraseMeme) { _ in
            self.txtTop.text = self.txtDefault
            self.txtBottom.text = self.txtDefault
            self.img.image = UIImage(named: "default-meme")
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func fontButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "fontSegue", sender: nil)
    }
    
    @IBAction func pickImageFromSource(_ sender: PickerImageButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        
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

//MARK: Private Methods
extension EditMemeViewController {
    
    func configureTextField(_ textField: UITextField) {
        textField.defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "impact", size: 40)!,
            NSAttributedString.Key.strokeWidth: -4.0,
        ]
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.textAlignment = .center
        textField.text = txtDefault
        textField.delegate = self
    }
    
    func configureUI (isShowing: Bool) {
        toolBarBottom.isHidden = isShowing
        navigationController?.setNavigationBarHidden(isShowing, animated: true)
    }
    
    func generateMemedImage() -> UIImage {
        
        configureUI(isShowing: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
}

//MARK: UIImagePickerControllerDelegate
extension EditMemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func shareButtonPressed() {
        
        if txtTop.text == txtDefault || txtBottom.text == txtDefault {
            
            let alert = Alerts.show(type: .noText)
            present(alert, animated: true, completion: nil)
            
        } else {
            
            let memedImage = generateMemedImage()
            let meme = Meme(topText: txtTop.text!, bottomText: txtBottom.text!, originalImage: img.image!, memedImage: memedImage)
            
            shareImage(image: meme.memedImage) {
                (UIApplication.shared.delegate as!
                    AppDelegate).memes.append(meme)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    func shareImage(image: UIImage, saved: @escaping () -> Void) {
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            activity, completed, items, error in
            
            if completed {
                saved()
            }
            
            self.configureUI(isShowing: false)
        }
        
        present(activityViewController, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            self.img.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}



