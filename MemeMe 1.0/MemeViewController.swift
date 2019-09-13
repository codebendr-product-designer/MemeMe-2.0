//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by codebendr on 12/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = Alerts.show(type: .noCamera)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let pickImageController = pickImage(with: .camera)
        present(pickImageController, animated: true, completion: nil)
        
    }
    
    @IBAction func pickImageFromCameraRoll(_ sender: Any) {
        let pickImageController = pickImage(with: .savedPhotosAlbum)
        present(pickImageController, animated: true, completion: nil)
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
            print("edited image \(image.description)")
        }
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

