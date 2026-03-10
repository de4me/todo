//
//  KeyboardObserver.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol KeyboardObserverInput: AnyObject {
    func registerObserver();
    func unregisterObserver();
}


fileprivate class KeyboardObserver: KeyboardObserverInput {
    
    private weak var interator: KeyboardInteratorOutput!;
    
    init(presenter: KeyboardInteratorOutput) {
        self.interator = presenter;
    }
    
    func registerObserver() {
        let nc = NotificationCenter.default;
        nc.addObserver(self, selector: #selector(keyboardWillChangeFrame(notify:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
    }
    
    func unregisterObserver() {
        let nc = NotificationCenter.default;
        nc.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
    }
    
    @objc private func keyboardWillChangeFrame(notify: Notification) {
        guard let info = notify.userInfo,
              let value = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return;
        }
        let rect = value.cgRectValue;
        if self.interator.rectInView(rect) {
            self.interator.updateKeyboardLayoutConstraint(value: rect.height);
        } else {
            self.interator.updateKeyboardLayoutConstraint(value: 0);
        }
        self.interator.updateConstraints();
    }
    
}


class KeyboardObserverConfigurator {
    
    static func configure(presenter: KeyboardInteratorOutput) -> KeyboardObserverInput {
        KeyboardObserver(presenter: presenter);
    }
    
}
