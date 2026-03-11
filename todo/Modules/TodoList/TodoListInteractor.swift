//
//  TodoListInteractor.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListInteractorInput: AnyObject {
    var presenter: TodoListPresenterProtocol? { get set }
    var datasource: TodoDataSourceInput? { get set }
    func dataSource(numberOfRowsInSection section: Int) -> Int;
    func dataSource(objectAt index: Int) -> Todo?;
    func viewWillAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func search(text: String?);
    func delete(todo: Todo);
    func save(todo: Todo);
}


protocol TodoListInteractorOutput: AnyObject {
    
}


class TodoListInteractor: TodoListInteractorInput {
    
    weak var presenter: TodoListPresenterProtocol?;
    var datasource: TodoDataSourceInput?;
    
    init(presenter: TodoListPresenterProtocol?, datasource: TodoDataSourceInput?) {
        self.presenter = presenter;
        self.datasource = datasource;
    }
    
    func viewWillAppear(_ animated: Bool) {
        try? self.datasource?.fetch();
    }
    
    func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func dataSource(numberOfRowsInSection section: Int) -> Int {
        self.datasource?.dataSource(numberOfRowsInSection: section) ?? 0;
    }
    
    func dataSource(objectAt index: Int) -> Todo? {
        self.datasource?.dataSource(objectAt: index);
    }
    
    private func databaseErrorHandler(_ error: Error?) {
        self.presenter?.didSaveWithError(error);
    }
    
    func delete(todo: Todo) {
        Database.shared.delete(objects: [todo], completionHandler: self.databaseErrorHandler);
    }
    
    func save(todo: Todo) {
        Database.shared.save(todos: [todo], completionHandler: self.databaseErrorHandler);
    }
    
    func search(text: String?) {
        try? self.datasource?.search(text: text);
    }
}


extension TodoListInteractor: TodoListInteractorOutput {
    
}


extension TodoListInteractor: TodoDataSourceOutput {

    func didChangeContent() {
        guard let presenter = self.presenter else {
            return;
        }
        let count = self.dataSource(numberOfRowsInSection: 0);
        presenter.update(total: count);
        presenter.updateTableView();
    }
    
}
