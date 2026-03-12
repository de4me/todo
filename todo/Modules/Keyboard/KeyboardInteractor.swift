//
//  KeyboardInteractor.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import CoreGraphics;


protocol KeyboardInteractorInput: AnyObject {
    var presenter: KeyboardInteractorOutput? { get set }
    var keyboardObserver: KeyboardObserverInput? { get set }
    func viewDidAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
}


protocol KeyboardInteractorOutput: AnyObject {
    func update(keyboardLayoutConstraint: CGFloat);
    func updateConstraints();
    func getValueBounds() -> CGRect;
    func getValueKeyboardSpace() -> CGFloat;
}


class KeyboardInteractor: KeyboardInteractorInput {
    
    weak var presenter: KeyboardInteractorOutput?;
    var keyboardObserver: KeyboardObserverInput?;
    
    init(presenter: KeyboardInteractorOutput?, keyboardObserver: KeyboardObserverInput?) {
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
