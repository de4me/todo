//
//  TodoListRouter.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListRouterInput: AnyObject {
    var presenter: TodoListPresenterProtocol? { get set };
    func edit(todo: Todo);
    func popup(info: TodoPopupInfo);
}


class TodoListRouter: TodoListRouterInput {
    
    weak var presenter: TodoListPresenterProtocol?;
    
    enum SegueName: String {
        case edit;
        case popup;
    }
    
    struct Name {
        static let edit = SegueName.edit.rawValue;
        static let popup = SegueName.popup.rawValue;
    }
    
    init(presenter: TodoListPresenterProtocol?) {
        self.presenter = presenter;
    }
    
    func edit(todo: Todo) {
        guard let presenter = self.presenter else {
            return;
        }
        presenter.endEditing(true);
        presenter.performSegue(withIdentifier: Name.edit, sender: todo);
    }
    
    func popup(info: TodoPopupInfo) {
        guard let presenter = self.presenter else {
            return;
        }
        presenter.endEditing(true);
        presenter.performSegue(withIdentifier: Name.popup, sender: info);
    }
    
}
