//
//  KeyboardViewDump.swift
//  todo
//
//  Created by DE4ME on 12.03.2026.
//


import CoreGraphics;
@testable import todo;


class KeyboardViewDump: KeyboardViewInput {
    
    var keyboardSpace: CGFloat = 8;
    var keyboardLayoutConstraint: CGFloat = .nan;
    var isUpdateConstraints: Bool = false;
    
    func update(keyboardLayoutConstraint: CGFloat) {
        self.keyboardLayoutConstraint = keyboardLayoutConstraint;
    }
    
    func updateConstraints() {
        self.isUpdateConstraints = true;
    }
    
    func getValueBounds() -> CGRect {
        .infinite;
    }
    
    func getValueKeyboardSpace() -> CGFloat {
        self.keyboardSpace;
    }

}
