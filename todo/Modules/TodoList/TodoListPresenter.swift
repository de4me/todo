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
        self.endEditing(true);
        let todo = todo ?? Todo();
        self.router?.edit(todo: todo);
    }
    
    func delete(todo: Todo?, force: Bool) {
        guard let todo else {
            return;
        }
        guard !force else {
            self.interactor?.delete(todo: todo);
            return;
        }
        let block: (Any) -> Void = { _ in
            self.interactor?.delete(todo: todo);
        }
        let message = String(localizedString: "message_delete_todo");
        let button = String(localizedString: "delete");
        self.view?.showAlert(message: message, button: button, destructive: true, actionSheeet: false, handler: block);
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
        self.endEditing(true);
        self.router?.popup(info: info);
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.interactor?.viewDidAppear(animated);
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
        let text = text?.trimmed().nilIfEmpty();
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
    
    func endEditing(_ force: Bool) {
        self.view?.endEditing(force);
    }
    
    func insert(tableView rows: [IndexPath]) {
        self.view?.insert(tableView: rows);
    }
    
    func delete(tableView rows: [IndexPath]) {
        self.view?.delete(tableView: rows);
    }
    
    func update(tableView rows: [IndexPath]) {
        self.view?.update(tableView: rows);
    }
    
}


extension TodoListPresenter: TodoListRouterOutput {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
}
