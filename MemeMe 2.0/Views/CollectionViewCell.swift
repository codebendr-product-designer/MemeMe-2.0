//
//  CollectionViewCell.swift
//  MemeMe 2.0
//
//  Created by codebendr on 20/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMeme: UIImageView!
    
    override func prepareForReuse() {
        imgMeme.image = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgMeme.layer.masksToBounds = false
        imgMeme.layer.cornerRadius = imgMeme.frame.height/2
        imgMeme.clipsToBounds = true
        
    }
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                print("sdfdsf----------------------\(meme.memedImage)")
                imgMeme.image = meme.memedImage
            }
        }
    }
    
}
