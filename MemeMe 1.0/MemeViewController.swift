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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnCamera.sourceType = .camera
        btnCameraRoll.sourceType = .photoLibrary
    }
    
    @IBAction func pickImageFromSource(_ sender: PickerImageButton) {
        
        var pickImageController: UIImagePickerController?
        
        switch sender.sourceType {
        case .camera:
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                let alert = Alerts.show(type: .noCamera)
                present(alert, animated: true, completion: nil)
                return
            }
            pickImageController = pickImage(with: .camera)
   
        case .photoLibrary :
            pickImageController = pickImage(with: .photoLibrary)
            
        default :
            //this will never be called.
            let alert = Alerts.show(type: .noSourceType)
            present(alert, animated: true, completion: nil)
        }
        
        guard let pickImage = pickImageController else {
            return
        }
        
        present(pickImage, animated: true, completion: nil)
        
    }
    
    
}

//MARK: UIImagePickerControllerDelegate
extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickImage(with type: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            self.imgMeme.image = image
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

