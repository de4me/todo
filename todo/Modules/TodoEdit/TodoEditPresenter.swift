//
//  TodoEditPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoEditPresenterProtocol: AnyObject {
    func performSegue(withIdentifier: String, sender: Any?);
    func updateTodo();
    func didSaveWithError(_ error: Error?);
}


fileprivate class TodoEditPresenter: AnyObject {
    
    private weak var view: TodoEditViewInput!;
    private var interactor: TodoEditInteratorInput!;
    private var router: TodoEditRouterInput!;
    
    init(view: TodoEditViewInput) {
        self.view = view
        self.interactor = TodoEditInteratorConfigurator.configure(presenter: self);
        self.router = TodoEditRouterConfigurator.configure(presenter: self);
    }
    
}


extension TodoEditPresenter: TodoEditViewOutput {
    
    func viewWillAppear(_ animated: Bool) {
        self.interactor.viewWillAppear(animated);
    }
    
    func save() {
        var todo = self.view.getValueTodo() ?? Todo();
        let result = self.view.getValueEditResult();
        if todo.id == nil && result.isEmpty || todo.isEqual(to: result) {
            self.router.close();
            return;
        }
        todo.title = result.title;
        todo.subtitle = result.subtitle;
        self.interactor.save(todo: todo);
    }
    
}


extension TodoEditPresenter: TodoEditPresenterProtocol {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
    func updateTodo() {
        let todo = self.view.getValueTodo();
        self.view.updateTodo(todo: todo);
    }
    
    func didSaveWithError(_ error: Error?) {
        OperationQueue.main.addOperation {
            if let error = error {
                self.view.showError(error);
            } else {
                self.router.close();
            }
        }
    }
    
}


class TodoEditPresenterConfigurator {
    
    static func configure(view: TodoEditViewInput) -> TodoEditPresenterProtocol & TodoEditViewOutput {
        TodoEditPresenter(view: view);
    }
    
}
