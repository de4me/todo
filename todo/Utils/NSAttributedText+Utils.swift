//
//  NSAttributedText+Utils.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


extension NSAttributedString {
    
    convenience init(string: String, font: UIFont?, color: UIColor?, strikeThrough: Bool = false) {
        let font = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize);
        let color = color ?? .lightGray;
        let attributes:[NSAttributedString.Key:Any];
        if strikeThrough {
            attributes = [ .font: font,
                           .foregroundColor: color,
                           .strikethroughStyle: NSUnderlineStyle.single.rawValue];
        } else {
            attributes = [ .font: font,
                           .foregroundColor: color];
        }
        self.init(string: string, attributes: attributes);
    }
    
}
