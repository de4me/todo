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
    func setValue(todo: Todo);
}


protocol TodoEditInteratorOutput: AnyObject {
    
}


fileprivate class TodoEditInterator: AnyObject {
    
    private weak var presenter: TodoEditPresenterProtocol!;
    private var todo: Todo?;
    
    init(presenter: TodoEditPresenterProtocol) {
        self.presenter = presenter;
    }
    
}


extension TodoEditInterator: TodoEditInteratorInput {
    
    func setValue(todo: Todo) {
        self.todo = todo;
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.presenter.update(todo: self.todo);
    }
    
    private func saveHandler(_ error: Error?) {
        guard let error else {
            return;
        }
        print(error);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        guard var todo = self.todo else {
            return;
        }
        let result = self.presenter.getValueEditResult();
        if todo.id == nil && result.isEmpty || todo.isEqual(to: result) {
            return;
        }
        todo.title = result.title;
        todo.subtitle = result.subtitle;
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
