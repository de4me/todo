//
//  CornerView.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


class CornerView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0;
    @IBInspectable var shadowOffset: CGSize = .zero;
    @IBInspectable var shadowColor: UIColor = .black;
    @IBInspectable var shadowOpacity: CGFloat = 0.1;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.updateCornerRadious();
        self.updateShadow();
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.updateCornerRadious();
    }
    
    private func updateCornerRadious() {
        self.layer.cornerRadius = self.cornerRadius >= 0 ? self.cornerRadius : min(self.bounds.width, self.bounds.height) / 2;
    }

    private func updateShadow() {
        guard self.shadowOffset != .zero else {
            return;
        }
        self.layer.shadowOffset = self.shadowOffset;
        self.layer.shadowColor = self.shadowColor.cgColor;
        self.layer.shadowOpacity = Float(self.shadowOpacity);
    }
}
