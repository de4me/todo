//
//  LabelView.swift
//  todo
//
//  Created by DE4ME on 13.03.2026.
//

import UIKit

class LabelView: UILabel {

    @IBInspectable var lineHeightMultiple: CGFloat = 1.2;
    @IBInspectable var letterSpacing: CGFloat = 0;
    
    override var text: String! {
        get {
            super.text;
        }
        set {
            self.update(string: newValue);
        }
    }
    
    private func update(string: String?) {
        guard let string = string, !string.isEmpty else {
            self.attributedText = nil;
            return;
        }
        let paragraph = NSMutableParagraphStyle();
        paragraph.lineHeightMultiple = self.lineHeightMultiple;
        paragraph.alignment = self.textAlignment;
        paragraph.lineBreakMode = self.lineBreakMode;
        let font = self.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize);
        let textcolor = self.textColor ?? UIColor.label;
        let attr: [NSAttributedString.Key:Any] = [
            .font: font,
            .foregroundColor: textcolor,
            .paragraphStyle: paragraph,
            .kern: self.letterSpacing
        ]
        self.attributedText = NSAttributedString(string: string, attributes: attr);
    }

}
