//
//  TodoEditInterator.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoEditInteratorInput: AnyObject {
    func viewWillAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func status(todo: Todo?);
}


protocol TodoEditInteratorOutput: AnyObject {
    
}


fileprivate class TodoEditInterator: AnyObject {
    
    private weak var presenter: TodoEditPresenterProtocol!;
    private var status: TodoEditStatusInput!;
    
    init(presenter: TodoEditPresenterProtocol) {
        self.presenter = presenter;
        self.status = TodoEditStatus();
    }
    
}


extension TodoEditInterator: TodoEditInteratorInput {
    
    func status(todo: Todo?) {
        self.status.todo = todo ?? Todo();
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.presenter.update(todo: self.status.todo);
    }
    
    private func saveHandler(_ error: Error?) {
        guard let error else {
            return;
        }
        print(error);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        guard var todo = status.todo else {
            return;
        }
        let result = self.presenter.editResult();
        if todo.id == nil && result.isEmpty || todo.isEqual(to: result) {
            return;
        }
        todo.title = result.title;
        todo.subtitle = result.subtitle;
        //TODO: Save todo
    }
    
}


extension TodoEditInterator: TodoEditInteratorOutput {
    
}


class TodoEditInteratorConfigurator {
    
    static func configure(presenter: TodoEditPresenterProtocol) -> TodoEditInteratorInput & TodoEditInteratorOutput {
        TodoEditInterator(presenter: presenter);
    }
    
}
