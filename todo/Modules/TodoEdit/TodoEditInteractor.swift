//
//  TodoEditInteractor.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoEditInteractorInput: AnyObject {
    var presenter: TodoEditInteractorOutput? { get set }
    func viewWillAppear(_ animated: Bool);
    func save();
}


protocol TodoEditInteractorOutput: AnyObject {
    func didSave();
    func update(todo: Todo?);
    func showError(_ error: Error);
    func getValueTodo() -> Todo?;
    func getValueEditResult() -> TodoEditResult?;
}


class TodoEditInteractor: TodoEditInteractorInput {
    
    weak var presenter: TodoEditInteractorOutput?;
    
    init(presenter: TodoEditInteractorOutput) {
        self.presenter = presenter;
    }
    
    func viewWillAppear(_ animated: Bool) {
        let todo = self.presenter?.getValueTodo();
        self.presenter?.update(todo: todo);
    }
    
    private func saveHandler(_ error: Error?) {
        OperationQueue.main.addOperation {
            if let error {
                self.presenter?.showError(error);
            } else {
                self.presenter?.didSave();
            }
        }
    }
    
    func save() {
        guard let presenter = self.presenter,
              let result = presenter.getValueEditResult()
        else {
            return;
        }
        var todo = presenter.getValueTodo() ?? Todo();
        if todo.id == nil && result.isEmpty || todo.isEqual(to: result) {
            presenter.didSave();
            return;
        }
        todo.title = result.title;
        todo.subtitle = result.subtitle;
        Database.shared.save(todos: [todo], completionHandler: self.saveHandler);
    }
    
}
