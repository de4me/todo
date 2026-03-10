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
    
    override func awakeFromNib() {
        super.awakeFromNib();
        if let view = self.leftActionView {
            self.leftView = view;
            self.leftViewMode = .always;
        }
        if let view = self.rightActionView {
            self.rightView = view;
            self.rightViewMode = .always;
        }
        self.updateCornerRadius();
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

}
