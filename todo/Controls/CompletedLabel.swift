//
//  CompletedLabel.swift
//  todo
//
//  Created by DE4ME on 10.03.2026.
//

import UIKit;


class CompletedLabel: UILabel {
    
    private var textColorBackup: UIColor?;

    override var text: String? {
        get {
            super.text;
        }
        set {
            self.update(text: newValue);
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.textColorBackup = self.textColor;
    }
    
    
    private func update(text: String?) {
        guard let text else {
            super.text = nil;
            return;
        }
        if self.isHighlighted {
            self.attributedText = NSAttributedString(string: text, font: self.font, color: self.highlightedTextColor, strikeThrough: true);
        } else {
            self.attributedText = NSAttributedString(string: text, font: self.font, color: self.textColorBackup, strikeThrough: false);
        }
    }

}
