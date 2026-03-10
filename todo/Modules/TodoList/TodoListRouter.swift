//
//  TodoListRouter.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListRouterInput: AnyObject {
    func edit(todo: Todo);
    func popup(info: TodoPopupInfo);
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
        self.presenter.performSegue(withIdentifier: Name.edit, sender: todo);
    }
    
    func popup(info: TodoPopupInfo) {
        self.presenter.performSegue(withIdentifier: Name.popup, sender: info);
    }
    
}


class TodoListRouterConfigurator {
    
    static func configure(presenter: TodoListPresenterProtocol) -> TodoListRouterInput {
        TodoListRouter(presenter: presenter);
    }
    
}
