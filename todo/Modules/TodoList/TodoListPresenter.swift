//
//  TodoListPresenter.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListPresenterProtocol: AnyObject {
    func performSegue(withIdentifier: String, sender: Any?);
    func updateTableView();
    func update(total: Int);
    func didSaveWithError(_ error: Error?);
    func endEditing(_ force: Bool);
}


fileprivate class TodoListPresenter: AnyObject {
    
    private weak var view: TodoListViewInput?;
    private var router: TodoListRouterInput!;
    private var interator: TodoListInteratorInput!;
    
    init(view: TodoListViewInput) {
        self.view = view;
        self.router = TodoListRouterConfigurator.configure(presenter: self);
        self.interator = TodoListInteratorConfigurator.configure(presenter: self);
    }
    
}


extension TodoListPresenter: TodoListPresenterProtocol {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
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
    
    func didSaveWithError(_ error: Error?) {
        guard let error else {
            return;
        }
        OperationQueue.main.addOperation {
            self.view?.showError(error);
        }
    }
    
    func endEditing(_ force: Bool) {
        self.view?.endEditing(force);
    }
    
}


extension TodoListPresenter: TodoListViewOutput {
    
    func edit(todo: Todo?) {
        let todo = todo ?? Todo();
        self.router.edit(todo: todo);
    }
    
    func delete(todo: Todo?) {
        guard let todo else {
            return;
        }
        self.interator.delete(todo: todo);
    }
    
    func complete(todo: Todo?, completed: Bool) {
        guard var todo else {
            return;
        }
        todo.completedDate = completed ? Date() : nil;
        self.interator.save(todo: todo);
    }
    
    func popup(info: TodoPopupInfo?) {
        guard let info else {
            return;
        }
        self.router.popup(info: info);
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.interator.viewWillAppear(animated);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.interator.viewWillDisappear(animated);
    }
    
    func dataSource(numberOfRowsInSection section: Int) -> Int {
        self.interator.dataSource(numberOfRowsInSection: section);
    }
    
    func dataSource(objectAt index: Int) -> Todo? {
        self.interator.dataSource(objectAt: index);
    }
    
    func search(text: String?) {
        self.interator.search(text: text);
    }
    
}


class TodoListPresenterConfigurator {
    
    static func configure(view: TodoListViewInput) -> TodoListPresenterProtocol & TodoListViewOutput {
        TodoListPresenter(view: view);
    }
    
}
