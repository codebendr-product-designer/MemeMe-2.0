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
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                imgMeme.image = meme.memedImage
            }
        }
    }
    
}
