//
//  KeyboardConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class KeyboardConfigurator {
    
    static func configure(view: KeyboardViewInput) -> KeyboardViewOutput {
        let presenter = KeyboardPresenterConfigurator.configure(view: view);
        return presenter;
    }
    
}
