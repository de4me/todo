//
//  TodoEditInterator.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoEditInteratorInput: AnyObject {
    func viewWillAppear(_ animated: Bool);
    func save(todo: Todo);
}


protocol TodoEditInteratorOutput: AnyObject {
    
}


fileprivate class TodoEditInterator: AnyObject {
    
    private weak var presenter: TodoEditPresenterProtocol?;
    
    init(presenter: TodoEditPresenterProtocol) {
        self.presenter = presenter;
    }
    
}


extension TodoEditInterator: TodoEditInteratorInput {
    
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


extension TodoEditInterator: TodoEditInteratorOutput {
    
}


class TodoEditInteratorConfigurator {
    
    static func configure(presenter: TodoEditPresenterProtocol) -> TodoEditInteratorInput & TodoEditInteratorOutput {
        TodoEditInterator(presenter: presenter);
    }
    
}
