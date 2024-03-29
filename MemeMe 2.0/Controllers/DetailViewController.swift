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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMemeButtonPressed))
        
        img.image = meme.memedImage
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func editMemeButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"EditMemeViewController") as! EditMemeViewController
        viewController.meme = meme
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
