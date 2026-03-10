//
//  TodoListRouter.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListRouterInput: AnyObject {
    func edit(todo: Todo);
    func popup(todo: Todo);
}


fileprivate class TodoListRouter: TodoListRouterInput {
    
    private weak var presenter: TodoListPresenterProtocol!;
    
    enum SegueName: String {
        case edit;
        case popup;
    }
    
    struct Name {
        static let edit = SegueName.edit.rawValue;
        static let popup = SegueName.popup.rawValue;
    }
    
    init(presenter: TodoListPresenterProtocol) {
        self.presenter = presenter;
    }
    
    func edit(todo: Todo) {
        //TODO: Edit todo
    }
    
    func popup(todo: Todo) {
        //TODO: Popup todo
    }
    
}


class TodoListRouterConfigurator {
    
    static func configure(presenter: TodoListPresenterProtocol) -> TodoListRouterInput {
        TodoListRouter(presenter: presenter);
    }
    
}
