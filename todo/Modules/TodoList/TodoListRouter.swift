//
//  TodoListRouter.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListRouterInput: AnyObject {
    var presenter: TodoListRouterOutput? { get set };
    func edit(todo: Todo);
    func popup(info: TodoPopupInfo);
}


protocol TodoListRouterOutput: AnyObject {
    func performSegue(withIdentifier: String, sender: Any?);
    func endEditing(_ force: Bool);
}


class TodoListRouter: TodoListRouterInput {
    
    weak var presenter: TodoListRouterOutput?;
    
    enum SegueName: String {
        case edit;
        case popup;
    }
    
    struct Name {
        static let edit = SegueName.edit.rawValue;
        static let popup = SegueName.popup.rawValue;
    }
    
    init(presenter: TodoListRouterOutput?) {
        self.presenter = presenter;
    }
    
    func edit(todo: Todo) {
        self.presenter?.performSegue(withIdentifier: Name.edit, sender: todo);
    }
    
    func popup(info: TodoPopupInfo) {
        self.presenter?.performSegue(withIdentifier: Name.popup, sender: info);
    }
    
}
