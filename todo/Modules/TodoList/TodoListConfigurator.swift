//
//  TodoListConfigurator.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


class TodoListConfigurator {
    
    static func configure(view: TodoListViewInput) -> TodoListViewOutput {
        let presenter = TodoListPresenterConfigurator.configure(view: view);
        return presenter;
    }
    
}
