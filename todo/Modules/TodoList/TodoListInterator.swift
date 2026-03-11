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
    private var datasource: TodoDataSourceInput!;
    
    init(presenter: TodoListPresenterProtocol) {
        self.presenter = presenter;
        self.datasource = TodoDataSourceConfigurator.configure(output: self);
    }
    
    func viewWillAppear(_ animated: Bool) {
        try? self.datasource.fetch();
    }
    
    func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func dataSource(numberOfRowsInSection section: Int) -> Int {
        self.datasource.dataSource(numberOfRowsInSection: section);
    }
    
    func dataSource(objectAt index: Int) -> Todo? {
        self.datasource.dataSource(objectAt: index);
    }
    
    private func databaseErrorHandler(_ error: Error?) {
        guard let error else {
            return;
        }
        print(error);
    }
    
    func delete(todo: Todo) {
        Database.shared.delete(objects: [todo], completionHandler: self.databaseErrorHandler);
    }
    
    func save(todo: Todo) {
        Database.shared.save(todos: [todo], completionHandler: self.databaseErrorHandler);
    }
    
    func search(text: String?) {
        //TODO: Search todo
    }
}


extension TodoListInterator: TodoListInteratorOutput {
    
}


extension TodoListInterator: TodoDataSourceOutput {

    func didChangeContent() {
        let count = self.dataSource(numberOfRowsInSection: 0);
        self.presenter.update(total: count);
        self.presenter.updateTableView();
    }
    
}


class TodoListInteratorConfigurator {
    
    static func configure(presenter: TodoListPresenterProtocol) -> TodoListInteratorInput & TodoListInteratorOutput {
        TodoListInterator(presenter: presenter);
    }
    
}
