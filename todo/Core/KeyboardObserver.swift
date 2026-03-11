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


protocol KeyboardObserverOutput: AnyObject {
    func keyboardFrameChanged(frame: CGRect);
}


class KeyboardObserver: AnyObject {
    
    weak var output: KeyboardObserverOutput?;
    
    init(output: KeyboardObserverOutput?) {
        self.output = output;
    }
    
    @objc private func keyboardWillChangeFrame(notify: Notification) {
        guard let output = self.output,
              let info = notify.userInfo,
              let value = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return;
        }
        let rect = value.cgRectValue;
        output.keyboardFrameChanged(frame: rect);
    }
    
}


extension KeyboardObserver: KeyboardObserverInput {
    
    func registerObserver() {
        let nc = NotificationCenter.default;
        nc.addObserver(self, selector: #selector(keyboardWillChangeFrame(notify:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
    }
    
    func unregisterObserver() {
        let nc = NotificationCenter.default;
        nc.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
    }
    
}
