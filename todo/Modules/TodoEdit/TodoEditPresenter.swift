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
        self.interactor?.save();
    }
    
}


extension TodoEditPresenter: TodoEditInteractorOutput {
    
    func didSave() {
        self.close();
    }
    
    func update(todo: Todo?) {
        guard let todo,
              let view = self.view
        else {
            return;
        }
        view.update(todo: todo);
    }
    
    func showError(_ error: Error) {
        self.view?.showError(error);
    }
    
    func getValueTodo() -> Todo? {
        self.view?.getValueTodo();
    }
    
    func getValueEditResult() -> TodoEditResult? {
        self.view?.getValueEditResult();
    }
    
}


extension TodoEditPresenter: TodoEditRouterOutput {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
}
