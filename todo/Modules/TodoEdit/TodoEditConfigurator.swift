//
//  TodoEditConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class TodoEditConfigurator: AnyObject {
    
    static func configure(view: TodoEditViewInput) -> TodoEditViewOutput {
        let presenter = TodoEditPresenterConfigurator.configure(view: view);
        return presenter;
    }
    
}
