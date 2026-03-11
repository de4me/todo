//
//  SearchTextField.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import UIKit;


class SearchTextField: UITextField {
    
    @IBOutlet var leftActionView: UIView?;
    @IBOutlet var rightActionView: UIView?;

    @IBInspectable var cornerRadius: CGFloat = 0;
    @IBInspectable var placeholderColor: UIColor = .placeholderText;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        if let view = self.leftActionView {
            view.tintColor = self.placeholderColor;
            self.leftView = view;
            self.leftViewMode = .always;
        }
        if let view = self.rightActionView {
            view.tintColor = self.placeholderColor;
            self.rightView = view;
            self.rightViewMode = .always;
        }
        self.updateCornerRadius();
        self.updatePlaceholderColor();
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.updateCornerRadius();
    }
    
    private func rectInset(_ rect: CGRect) -> CGRect {
        let left: CGFloat = self.leftView?.frame.width ?? self.cornerRadius;
        let right: CGFloat = self.rightView?.frame.width ?? self.cornerRadius;
        let inset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right);
        return rect.inset(by: inset);
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        self.rectInset(bounds);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        self.rectInset(bounds);
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        self.rectInset(bounds);
    }
    
    private func updateCornerRadius() {
        self.layer.cornerRadius = self.cornerRadius > 0 ? self.cornerRadius : min(self.frame.height, self.frame.width) / 2;
    }
    
    private func updatePlaceholderColor() {
        guard let placeholder = self.placeholder else {
            return;
        }
        let attr: [NSAttributedString.Key:Any] = [
            .foregroundColor: self.placeholderColor
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attr);
    }

}
