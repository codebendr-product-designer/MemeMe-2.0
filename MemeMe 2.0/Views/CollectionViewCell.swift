//
//  CollectionViewCell.swift
//  MemeMe 2.0
//
//  Created by codebendr on 20/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    
    
    override func prepareForReuse() {
        img.image = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        img.layer.masksToBounds = false
        img.layer.cornerRadius = img.frame.height/2
        img.clipsToBounds = true
        
    }
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                img.image = UIImage(named: "default-meme")//meme.memedImage
            }
        }
    }
    
}
