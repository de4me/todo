//
//  KeyboardViewController.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol KeyboardViewInput: AnyObject {
    func updateKeyboardSpace(_ value: CGFloat);
    func updateKeyboardLayoutConstraint(value: CGFloat);
    func updateConstraints();
    func rectInView(_ rect: CGRect) -> Bool;
}


protocol KeyboardViewOutput: AnyObject {
    func viewDidAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
}


class KeyboardViewController: UIViewController {
    
    @IBInspectable var keyboardSpace: CGFloat = 8;
    @IBOutlet var keyboardLayoutConstraint: NSLayoutConstraint?;
    
    private var presenter: KeyboardViewOutput!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.presenter = KeyboardConfigurator.configure(view: self);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.presenter.viewDidAppear(animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.presenter.viewWillDisappear(animated);
    }

}


extension KeyboardViewController: KeyboardViewInput {
    
    func updateKeyboardLayoutConstraint(value: CGFloat) {
        self.keyboardLayoutConstraint?.constant = value > 0 ? value + self.keyboardSpace : 0;
    }
    
    func updateKeyboardSpace(_ value: CGFloat) {
        self.keyboardSpace = value + self.keyboardSpace;
    }
    
    func rectInView(_ rect: CGRect) -> Bool {
        rect.intersects(self.view.bounds);
    }
    
    func updateConstraints() {
        self.view.updateConstraints();
    }
    
}
