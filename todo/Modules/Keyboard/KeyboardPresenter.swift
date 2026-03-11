//
//  KeyboardPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import CoreGraphics;


protocol KeyboardPresenterProtocol: AnyObject {
    var view: KeyboardViewInput? { get set }
    var interactor: KeyboardInteractorInput? { get set }
    func updateKeyboardLayoutConstraint(value: CGFloat);
    func updateConstraints();
    func getValueBounds() -> CGRect;
    func getValueKeyboardSpace() -> CGFloat;
}


class KeyboardPresenter: KeyboardPresenterProtocol {
    
    weak var view: KeyboardViewInput?;
    var interactor: KeyboardInteractorInput?;
    
    init(view: KeyboardViewInput?, interactor: KeyboardInteractorInput?) {
        self.view = view;
        self.interactor = interactor;
    }
    
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


extension KeyboardPresenter: KeyboardViewOutput {
    
    func viewDidAppear(_ animated: Bool) {
        self.interactor?.viewDidAppear(animated);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.interactor?.viewDidAppear(animated);
    }
}
