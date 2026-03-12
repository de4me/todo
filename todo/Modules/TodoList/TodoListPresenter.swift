//
//  TodoListPresenter.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListPresenterProtocol: AnyObject {
    var view: TodoListViewInput? { get set }
    var router: TodoListRouterInput? { get set }
    var interactor: TodoListInteractorInput? { get set }
}


class TodoListPresenter: TodoListPresenterProtocol {
    
    weak var view: TodoListViewInput?;
    var router: TodoListRouterInput?;
    var interactor: TodoListInteractorInput?;
    
    init(view: TodoListViewInput?, interactor: TodoListInteractorInput?, router: TodoListRouterInput?) {
        self.view = view;
        self.interactor = interactor;
        self.router = router;
    }
    
}


extension TodoListPresenter: TodoListViewOutput {
    
    func edit(todo: Todo?) {
        let todo = todo ?? Todo();
        self.router?.edit(todo: todo);
    }
    
    func delete(todo: Todo?) {
        guard let todo else {
            return;
        }
        self.interactor?.delete(todo: todo);
    }
    
    func complete(todo: Todo?, completed: Bool) {
        guard var todo else {
            return;
        }
        todo.completedDate = completed ? Date() : nil;
        self.interactor?.save(todo: todo);
    }
    
    func popup(info: TodoPopupInfo?) {
        guard let info else {
            return;
        }
        self.router?.popup(info: info);
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.interactor?.viewWillAppear(animated);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.interactor?.viewWillDisappear(animated);
    }
    
    func dataSource(numberOfRowsInSection section: Int) -> Int {
        self.interactor?.dataSource(numberOfRowsInSection: section) ?? 0;
    }
    
    func dataSource(objectAt index: Int) -> Todo? {
        self.interactor?.dataSource(objectAt: index);
    }
    
    func search(text: String?) {
        self.interactor?.search(text: text);
    }
    
}


extension TodoListPresenter: TodoListInteractorOutput {
    
    func updateTableView() {
        self.view?.updateTableView();
    }
    
    func update(total: Int) {
        guard let view = self.view else {
            return;
        }
        let format = String(localizedString: "tasks_count");
        let string = String(format: format, total);
        view.update(total: string);
    }
    
    func showError(_ error: Error) {
        self.view?.showError(error);
    }
    
}


extension TodoListPresenter: TodoListRouterOutput {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
    func endEditing(_ force: Bool) {
        self.view?.endEditing(force);
    }
    
}
