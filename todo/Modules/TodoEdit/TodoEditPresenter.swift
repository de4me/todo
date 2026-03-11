//
//  TodoEditPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoEditPresenterProtocol: AnyObject {
    var view: TodoEditViewInput? { get set }
    var interactor: TodoEditInteratorInput? { get set }
    var router: TodoEditRouterInput? { get set }
    func performSegue(withIdentifier: String, sender: Any?);
    func updateTodo();
    func didSaveWithError(_ error: Error?);
}


class TodoEditPresenter: AnyObject {
    
    weak var view: TodoEditViewInput?;
    var interactor: TodoEditInteratorInput?;
    var router: TodoEditRouterInput?;
    
    init(view: TodoEditViewInput?, interactor: TodoEditInteratorInput?, router: TodoEditRouterInput?) {
        self.view = view
        self.interactor = interactor;
        self.router = router;
    }
    
}


extension TodoEditPresenter: TodoEditViewOutput {
    
    func viewWillAppear(_ animated: Bool) {
        self.interactor?.viewWillAppear(animated);
    }
    
    func save() {
        guard let view = self.view else {
            return;
        }
        var todo = view.getValueTodo() ?? Todo();
        let result = view.getValueEditResult();
        if todo.id == nil && result.isEmpty || todo.isEqual(to: result) {
            self.router?.close();
            return;
        }
        todo.title = result.title;
        todo.subtitle = result.subtitle;
        self.interactor?.save(todo: todo);
    }
    
}


extension TodoEditPresenter: TodoEditPresenterProtocol {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
    func updateTodo() {
        guard let view = self.view else {
            return;
        }
        let todo = view.getValueTodo();
        view.updateTodo(todo: todo);
    }
    
    func didSaveWithError(_ error: Error?) {
        OperationQueue.main.addOperation {
            if let error = error {
                self.view?.showError(error);
            } else {
                self.router?.close();
            }
        }
    }
    
}
