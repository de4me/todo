//
//  KeyboardInterator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol KeyboardInteratorInput: AnyObject {
    func viewDidAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
}

protocol KeyboardInteratorOutput: AnyObject {
    func rectInView(_ rect: CGRect) -> Bool;
    func updateKeyboardLayoutConstraint(value: CGFloat);
    func updateConstraints();
}



fileprivate class KeyboardInterator: AnyObject {
    
    private weak var presenter: KeyboardPresenterProtocol!;
    private var keyboardObserver: KeyboardObserverInput!;
    
    init(presenter: KeyboardPresenterProtocol) {
        self.presenter = presenter;
        self.keyboardObserver = KeyboardObserverConfigurator.configure(presenter: self);
    }
    
}


extension KeyboardInterator: KeyboardInteratorInput {
    
    func viewDidAppear(_ animated: Bool) {
        self.keyboardObserver.registerObserver();
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.keyboardObserver.unregisterObserver();
    }
    
}


extension KeyboardInterator: KeyboardInteratorOutput {
    
    func rectInView(_ rect: CGRect) -> Bool {
        self.presenter.rectInView(rect);
    }
    
    func updateKeyboardLayoutConstraint(value: CGFloat) {
        self.presenter.updateKeyboardLayoutConstraint(value: value);
    }
    
    func updateConstraints() {
        self.presenter.updateConstraints();
    }
    
}


class KeyboardInteratorConfigurator {
    
    static func configure(presenter: KeyboardPresenterProtocol) -> KeyboardInteratorInput & KeyboardInteratorOutput {
        KeyboardInterator(presenter: presenter);
    }
    
}
