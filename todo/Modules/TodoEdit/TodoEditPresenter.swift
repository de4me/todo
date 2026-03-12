//
//  TodoEditPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoEditPresenterProtocol: AnyObject {
    var view: TodoEditViewInput? { get set }
    var interactor: TodoEditInteractorInput? { get set }
    var router: TodoEditRouterInput? { get set }
}


class TodoEditPresenter: TodoEditPresenterProtocol {
    
    weak var view: TodoEditViewInput?;
    var interactor: TodoEditInteractorInput?;
    var router: TodoEditRouterInput?;
    
    init(view: TodoEditViewInput?, interactor: TodoEditInteractorInput?, router: TodoEditRouterInput?) {
        self.view = view
        self.interactor = interactor;
        self.router = router;
    }
    
}


extension TodoEditPresenter: TodoEditViewOutput {
    
    func viewWillAppear(_ animated: Bool) {
        self.interactor?.viewWillAppear(animated);
    }
    
    func close() {
        self.router?.close();
    }
    
    func save() {
        guard let view = self.view else {
            return;
        }
        var todo = view.getValueTodo() ?? Todo();
        let result = view.getValueEditResult();
        if todo.id == nil && result.isEmpty || todo.isEqual(to: result) {
            self.close();
            return;
        }
        todo.title = result.title;
        todo.subtitle = result.subtitle;
        self.interactor?.save(todo: todo);
    }
    
}


extension TodoEditPresenter: TodoEditInteractorOutput {
    
    func didSave() {
        self.close();
    }
    
    func updateTodo() {
        guard let view = self.view else {
            return;
        }
        let todo = view.getValueTodo();
        view.updateTodo(todo: todo);
    }
    
    func showError(_ error: Error) {
        self.view?.showError(error);
    }
    
}


extension TodoEditPresenter: TodoEditRouterOutput {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
}
