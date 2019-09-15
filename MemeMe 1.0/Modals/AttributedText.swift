//
//  AttributedText.swift
//  MemeMe 1.0
//
//  Created by codebendr on 15/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

//lets composite attributed text so we can handle expansion of text attributes in the future
//using the builder pattern
/*
 psuedo
 sameText.attributedText = AttributedText("hellow world",text: "world").change(color: "#000000").medium(font: 20).build()
 */
struct AttributedText {
    
    private var attribute: NSMutableAttributedString
    private var range: NSRange
    
    init(_ text: String, highlight: String) {
        self.attribute = NSMutableAttributedString(string: text)
        self.range = (text as NSString).range(of: highlight)
    }
    
    init(text: String) {
        self.attribute = NSMutableAttributedString(string: text)
        self.range = (text as NSString).range(of: text)
    }
    
    func font(name: String = "",size: CGFloat = 40.0) {
        attribute.addAttribute(.font, value: UIFont(name: name, size: size)! , range: range)
    }
    
    func fill(color: UIColor) -> AttributedText {
           self.attribute.addAttribute(.foregroundColor, value: color , range: range)
           return self
       }
    
    func stroke(color: UIColor, width: CGFloat = 2) -> AttributedText {
        self.attribute.addAttribute(.strokeColor, value: color , range: range)
        self.attribute.addAttribute(.strokeWidth, value: width , range: range)
        return self
    }
    
    func build() -> NSMutableAttributedString {
        return attribute
    }
    
}
