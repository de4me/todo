//
//  TodoListPopupRouter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoListPopupRouterInput: AnyObject {
    var presenter: TodoListPopupRouterOutput? { get set }
    func close();
    func edit(todo: Todo?);
    func delete(todo: Todo?);
    func share(todo: Todo?);
}


protocol TodoListPopupRouterOutput: AnyObject {
    func performSegue(withIdentifier: String, sender: Any?);
}


class TodoListPopupRouter: TodoListPopupRouterInput  {
    
    weak var presenter: TodoListPopupRouterOutput?;
    
    enum SegueName: String, CaseIterable {
        case close;
        case edit;
        case delete;
        case share;
    }
    
    struct Name {
        static let close = SegueName.close.rawValue;
        static let edit = SegueName.edit.rawValue;
        static let delete = SegueName.delete.rawValue;
        static let share = SegueName.share.rawValue;
    }
    
    init(presenter: TodoListPopupRouterOutput?) {
        self.presenter = presenter;
    }
    
    func close() {
        self.presenter?.performSegue(withIdentifier: Name.close, sender: nil);
    }
    
    func edit(todo: Todo?) {
        self.presenter?.performSegue(withIdentifier: Name.edit, sender: todo);
    }
    
    func delete(todo: Todo?) {
        self.presenter?.performSegue(withIdentifier: Name.delete, sender: todo);
    }
    
    func share(todo: Todo?) {
        self.presenter?.performSegue(withIdentifier: Name.share, sender: todo);
    }
    
}
