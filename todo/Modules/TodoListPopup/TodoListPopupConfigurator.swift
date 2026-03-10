//
//  TodoListPopupConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class TodoListPopupConfigurator: AnyObject {
 
    static func configure(view: TodoListPopupViewInput) -> TodoListPopupViewOutput {
        let presenter = TodoListPopupPresenterConfigurator.configure(view: view);
        return presenter;
    }
    
}
