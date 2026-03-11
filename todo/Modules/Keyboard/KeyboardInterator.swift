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


protocol KeyboardInteratorConfiguratorProtocol: AnyObject {
    var presenter: KeyboardPresenterProtocol? { get set }
    var keyboardObserver: KeyboardObserverInput? { get set }
}


class KeyboardInterator: KeyboardInteratorConfiguratorProtocol {
    
    weak var presenter: KeyboardPresenterProtocol?;
    var keyboardObserver: KeyboardObserverInput?;
    
    init(presenter: KeyboardPresenterProtocol?, keyboardObserver: KeyboardObserverInput?) {
        self.presenter = presenter;
        self.keyboardObserver = keyboardObserver;
    }
    
}


extension KeyboardInterator: KeyboardInteratorInput {
    
    func viewDidAppear(_ animated: Bool) {
        self.keyboardObserver?.registerObserver();
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.keyboardObserver?.unregisterObserver();
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
