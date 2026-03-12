//
//  KeyboardInteractor.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import CoreGraphics;


protocol KeyboardInteractorInput: AnyObject {
    var presenter: KeyboardPresenterProtocol? { get set }
    var keyboardObserver: KeyboardObserverInput? { get set }
    func viewDidAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
}


protocol KeyboardInteractorOutput: AnyObject {
    
}


class KeyboardInteractor: KeyboardInteractorInput {
    
    weak var presenter: KeyboardPresenterProtocol?;
    var keyboardObserver: KeyboardObserverInput?;
    
    init(presenter: KeyboardPresenterProtocol?, keyboardObserver: KeyboardObserverInput?) {
        self.presenter = presenter;
        self.keyboardObserver = keyboardObserver;
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.keyboardObserver?.registerObserver();
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.keyboardObserver?.unregisterObserver();
    }
    
}


extension KeyboardInteractor: KeyboardInteractorOutput {
    
}


extension KeyboardInteractor: KeyboardObserverOutput {
    
    func keyboardFrameChanged(frame: CGRect) {
        guard let presenter = self.presenter else {
            return;
        }
        let rect = presenter.getValueBounds();
        if frame.intersects(rect) {
            presenter.update(keyboardLayoutConstraint: frame.height);
        } else {
            presenter.update(keyboardLayoutConstraint: 0);
        }
        presenter.updateConstraints();
    }
    
}
