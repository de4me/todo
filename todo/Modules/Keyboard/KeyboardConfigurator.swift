//
//  KeyboardConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class KeyboardConfigurator {
    
    static func configure(view: KeyboardViewInput) -> KeyboardViewOutput & KeyboardPresenterProtocol {
        let presenter = KeyboardPresenter(view: view, interactor: nil);
        let interactor = KeyboardInteractor(presenter: presenter, keyboardObserver: nil);
        let keyboardObserver = KeyboardObserver(output: interactor);
        interactor.keyboardObserver = keyboardObserver;
        presenter.interactor = interactor;
        return presenter;
    }
    
}
