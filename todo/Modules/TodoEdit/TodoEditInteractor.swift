//
//  TodoEditInteractor.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoEditInteractorInput: AnyObject {
    var presenter: TodoEditPresenterProtocol? { get set }
    func viewWillAppear(_ animated: Bool);
    func save(todo: Todo);
}


protocol TodoEditInteractorOutput: AnyObject {
    
}


class TodoEditInteractor: TodoEditInteractorInput {
    
    weak var presenter: TodoEditPresenterProtocol?;
    
    init(presenter: TodoEditPresenterProtocol) {
        self.presenter = presenter;
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.presenter?.updateTodo();
    }
    
    private func saveHandler(_ error: Error?) {
        self.presenter?.didSaveWithError(error);
    }
    
    func save(todo: Todo) {
        Database.shared.save(todos: [todo], completionHandler: saveHandler);
    }
    
}


extension TodoEditInteractor: TodoEditInteractorOutput {
    
}
