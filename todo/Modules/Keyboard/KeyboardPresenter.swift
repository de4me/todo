//
//  KeyboardPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import CoreGraphics;


protocol KeyboardPresenterProtocol: AnyObject {
    func updateKeyboardLayoutConstraint(value: CGFloat);
    func updateConstraints();
    func getValueBounds() -> CGRect;
    func getValueKeyboardSpace() -> CGFloat;
}


fileprivate class KeyboardPresenter: AnyObject {
    
    private weak var view: KeyboardViewInput?;
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
    
    func updateKeyboardLayoutConstraint(value: CGFloat) {
        guard let view = self.view else {
            return;
        }
        let value = value > 0 ? value + view.getValueKeyboardSpace() : 0;
        view.updateKeyboardLayoutConstraint(value: value);
    }
    
    func updateConstraints() {
        self.view?.updateConstraints();
    }
    
    func getValueBounds() -> CGRect {
        self.view?.getValueBounds() ?? .zero;
    }
    
    func getValueKeyboardSpace() -> CGFloat {
        self.view?.getValueKeyboardSpace() ?? 0;
    }
    
}


class KeyboardPresenterConfigurator {
    
    static func configure(view: KeyboardViewInput) -> KeyboardPresenterProtocol & KeyboardViewOutput {
        KeyboardPresenter(view: view);
    }
    
}
