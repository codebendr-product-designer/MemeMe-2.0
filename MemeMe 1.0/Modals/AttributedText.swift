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
 sameText.attributedText = AttributedText("hellow world",text: "world").fill(hex : "#000000").medium(font: 20).build()
 */
struct TextAttributes {
    
    private var attribute: NSMutableAttributedString
    private var range: NSRange
    
    init(_ text: String, highlight: String) {
        self.attribute = NSMutableAttributedString(string: text)
        self.range = (text as NSString).range(of: highlight)
    }
    
    init(text: String = "") {
        self.attribute = NSMutableAttributedString(string: text)
        self.range = (text as NSString).range(of: text)
    }
    
    func font(name: String = "impact",size: CGFloat = 40.0) {
        attribute.addAttribute(.font, value: UIFont(name: name, size: size)! , range: range)
    }
    
    func fill(hex: String = "#FFFFFF") -> TextAttributes {
        self.attribute.addAttribute(.foregroundColor, value: toUIColor(hex: hex) , range: range)
           return self
       }
    
    func stroke(hex: String = "#000000", width: CGFloat = 2) -> TextAttributes {
        self.attribute.addAttribute(.strokeColor, value: toUIColor(hex: hex) , range: range)
        self.attribute.addAttribute(.strokeWidth, value: width , range: range)
        return self
    }
    
    private func toUIColor(hex: String) -> UIColor {
           var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
           
           if (cString.hasPrefix("#")) {
               cString.remove(at: cString.startIndex)
           }
           
           if ((cString.count) != 6) {
               return UIColor.gray
           }
           
           var rgbValue:UInt32 = 0
           Scanner(string: cString).scanHexInt32(&rgbValue)
           
           return UIColor(
               red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
               alpha: CGFloat(1.0)
           )
       }
    
    func build() -> NSMutableAttributedString {
        return attribute
    }
    
}
