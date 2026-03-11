//
//  TextView.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


class TextView: UITextView {
    
    @IBInspectable var placeHolderColor: UIColor = .placeholderText;
    @IBInspectable var placeHolderString: String?;
    
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
    
    private(set) var isPlaceholder: Bool = true;
    private var textColorBackup: UIColor?;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.textColorBackup = self.textColor;
        self.textContainer.lineFragmentPadding = 0;
        self.updateTypingAttr();
        guard let placeHolderString else {
            return;
        }
        self.placeHolderString = String(localizedString: placeHolderString);
        self.showPlaceholder();
    }
    
    override func becomeFirstResponder() -> Bool {
        if self.isPlaceholder {
            self.update(string: "");
        }
        return super.becomeFirstResponder();
    }
    
    override func resignFirstResponder() -> Bool {
        if String.isEmpty(string: self.text) {
            self.update(string: nil);
        }
        return super.resignFirstResponder();
    }
    
    private func showPlaceholder() {
        self.isPlaceholder = true;
        guard let string = self.placeHolderString else {
            return;
        }
        self.textColor = self.placeHolderColor;
        super.text = string;
    }
    
    private func update(string: String?) {
        guard let string else {
            showPlaceholder();
            return;
        }
        self.isPlaceholder = false;
        super.text = string;
        self.textColor = self.textColorBackup;
    }
    
    private func updateTypingAttr() {
        let paragraph = NSMutableParagraphStyle();
        paragraph.lineHeightMultiple = self.lineHeightMultiple;
        paragraph.alignment = self.textAlignment;
        let font = self.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize);
        let textcolor = self.textColor ?? UIColor.label;
        let attr: [NSAttributedString.Key:Any] = [
            .font: font,
            .foregroundColor: textcolor,
            .paragraphStyle: paragraph,
            .kern: self.letterSpacing
        ]
        self.typingAttributes = attr;
    }

}
