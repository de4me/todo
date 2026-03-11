//
//  KeyboardInterator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import CoreGraphics;


protocol KeyboardInteratorInput: AnyObject {
    func viewDidAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
}


protocol KeyboardInteratorOutput: AnyObject {
    
}


fileprivate class KeyboardInterator: AnyObject {
    
    private weak var presenter: KeyboardPresenterProtocol?;
    private var keyboardObserver: KeyboardObserverInput!;
    
    init(presenter: KeyboardPresenterProtocol) {
        self.presenter = presenter;
        self.keyboardObserver = KeyboardObserverConfigurator.configure(output: self);
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
    
}


extension KeyboardInterator: KeyboardObserverOutput {
    
    func keyboardFrameChanged(frame: CGRect) {
        guard let presenter = self.presenter else {
            return;
        }
        let rect = presenter.getValueBounds();
        if frame.intersects(rect) {
            presenter.updateKeyboardLayoutConstraint(value: frame.height);
        } else {
            presenter.updateKeyboardLayoutConstraint(value: 0);
        }
        presenter.updateConstraints();
    }
    
}


class KeyboardInteratorConfigurator {
    
    static func configure(presenter: KeyboardPresenterProtocol) -> KeyboardInteratorInput & KeyboardInteratorOutput {
        KeyboardInterator(presenter: presenter);
    }
    
}
