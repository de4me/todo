//
//  TodoListInterator.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListInteratorInput: AnyObject {
    func dataSource(numberOfRowsInSection section: Int) -> Int;
    func dataSource(objectAt index: Int) -> Todo?;
    func viewWillAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func search(text: String?);
    func delete(todo: Todo);
    func save(todo: Todo);
}


protocol TodoListInteratorOutput: AnyObject {
    
}


fileprivate class TodoListInterator: TodoListInteratorInput {
    
    private weak var presenter: TodoListPresenterProtocol!;
    
    private var todos: [Todo] = [
        .init(title: "1", subtitle: "A", createdDate: Date()),
        .init(title: "2", subtitle: "B", createdDate: Date()),
        .init(title: "3", subtitle: "C", createdDate: Date()),
        .init(title: "4", subtitle: "D", createdDate: Date(), completedDate: Date()),
    ];
    
    init(presenter: TodoListPresenterProtocol) {
        self.presenter = presenter;
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.presenter.updateTableView();
        self.presenter.update(total: todos.count);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func dataSource(numberOfRowsInSection section: Int) -> Int {
        self.todos.count;
    }
    
    func dataSource(objectAt index: Int) -> Todo? {
        self.todos[index];
    }
    
    private func databaseErrorHandler(_ error: Error?) {
        guard let error else {
            return;
        }
        print(error);
    }
    
    func delete(todo: Todo) {
        //TODO: Delete todo
    }
    
    func save(todo: Todo) {
        //TODO: Save todo
    }
    
    func search(text: String?) {
        //TODO: Search todo
    }
}


extension TodoListInterator: TodoListInteratorOutput {
    
}


class TodoListInteratorConfigurator {
    
    static func configure(presenter: TodoListPresenterProtocol) -> TodoListInteratorInput & TodoListInteratorOutput {
        TodoListInterator(presenter: presenter);
    }
    
}
