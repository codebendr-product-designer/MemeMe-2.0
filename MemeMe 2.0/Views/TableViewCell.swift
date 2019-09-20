//
//  TableViewCell.swift
//  MemeMe 2.0
//
//  Created by codebendr on 20/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtMeme: UILabel!
    @IBOutlet weak var imgMeme: UIImageView!
    
    override func prepareForReuse() {
        txtMeme.text = .none
        imgMeme.image = .none
    }
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                txtMeme.text = "\(meme.topText) - \(meme.bottomText)"
                imgMeme.image = meme.originalImage
            }
        }
    }
    
}
