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
        // Do any additional setup after loading the view.
    }


}

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickImage(with type: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage]
        print(image.debugDescription)
        
    }
    
}

