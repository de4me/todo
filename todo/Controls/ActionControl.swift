//
//  ActionControl.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


class ActionControl: UIControl {

    @IBOutlet var titleLabel: UILabel?;
    @IBOutlet var imageView: UIView?;
    @IBOutlet var selectionView: UIView?;
    
    @IBInspectable var alphaSelected: CGFloat = 0.6;
    
    override var isSelected: Bool {
        didSet {
            self.updateSelected();
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.isSelected = true;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event);
        self.isSelected = false;
        self.sendActions(for: .primaryActionTriggered);
    }
    
    private func updateSelected() {
        if self.isSelected {
            self.selectionView?.isHidden = false;
            self.imageView?.alpha = self.alphaSelected
            self.titleLabel?.alpha = self.alphaSelected;
        } else {
            self.selectionView?.isHidden = true;
            self.imageView?.alpha = 1;
            self.titleLabel?.alpha = 1;
        }
    }
}
