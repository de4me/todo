//
//  KeyboardConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class KeyboardConfigurator {
    
    static func configure(view: KeyboardViewInput) -> KeyboardViewOutput {
        let presenter = KeyboardPresenter(view: view, interator: nil);
        let interator = KeyboardInterator(presenter: presenter, keyboardObserver: nil);
        let keyboardObserver = KeyboardObserver(output: interator);
        interator.keyboardObserver = keyboardObserver;
        presenter.interator = interator;
        return presenter;
    }
    
}
