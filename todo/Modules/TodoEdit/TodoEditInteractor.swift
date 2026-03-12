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
    func save(todo: Todo);
}


protocol TodoEditInteractorOutput: AnyObject {
    func didSave();
    func updateTodo();
    func showError(_ error: Error);
}


class TodoEditInteractor: TodoEditInteractorInput {
    
    weak var presenter: TodoEditInteractorOutput?;
    
    init(presenter: TodoEditInteractorOutput) {
        self.presenter = presenter;
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.presenter?.updateTodo();
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
    
    func save(todo: Todo) {
        Database.shared.save(todos: [todo], completionHandler: self.saveHandler);
    }
    
}
