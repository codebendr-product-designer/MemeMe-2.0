//
//  DetailViewController.swift
//  MemeMe 2.0
//
//  Created by codebendr on 20/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(editMemeButtonPressed))
        
        img.image = meme.memedImage
        
    }
    
    @objc func editMemeButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"EditMemeViewController") as! EditMemeViewController
        viewController.meme = meme
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
