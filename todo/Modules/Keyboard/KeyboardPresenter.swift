//
//  KeyboardPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol KeyboardPresenterProtocol: AnyObject {
    func rectInView(_ rect: CGRect) -> Bool;
    func updateKeyboardLayoutConstraint(value: CGFloat);
    func updateConstraints();
}


fileprivate class KeyboardPresenter: AnyObject {
    
    private weak var view: KeyboardViewInput!;
    private var interator: KeyboardInteratorInput!;
    
    init(view: KeyboardViewInput) {
        self.view = view;
        self.interator = KeyboardInteratorConfigurator.configure(presenter: self);
    }
    
}


extension KeyboardPresenter: KeyboardViewOutput {
    
    func viewDidAppear(_ animated: Bool) {
        self.interator.viewDidAppear(animated);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.interator.viewDidAppear(animated);
    }
}


extension KeyboardPresenter: KeyboardPresenterProtocol {
    
    func rectInView(_ rect: CGRect) -> Bool {
        self.view.rectInView(rect);
    }
    
    func updateKeyboardLayoutConstraint(value: CGFloat) {
        self.view.updateKeyboardLayoutConstraint(value: value);
    }
    
    func updateConstraints() {
        self.view.updateConstraints();
    }
    
}


class KeyboardPresenterConfigurator {
    
    static func configure(view: KeyboardViewInput) -> KeyboardPresenterProtocol & KeyboardViewOutput {
        KeyboardPresenter(view: view);
    }
    
}
