//
//  KeyboardViewController.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol KeyboardViewInput: AnyObject {
    func updateKeyboardLayoutConstraint(value: CGFloat);
    func updateConstraints();
    func getValueBounds() -> CGRect;
    func getValueKeyboardSpace() -> CGFloat;
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
        self.keyboardLayoutConstraint?.constant = value;
    }
    
    func updateConstraints() {
        self.view.updateConstraints();
    }
    
    func getValueBounds() -> CGRect {
        self.view.bounds;
    }
    
    func getValueKeyboardSpace() -> CGFloat {
        self.keyboardSpace;
    }
    
}
