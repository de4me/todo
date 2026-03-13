//
//  TodoListInteractor.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoListInteractorInput: AnyObject {
    var presenter: TodoListInteractorOutput? { get set }
    var datasource: TodoDataSourceInput? { get set }
    func dataSource(numberOfRowsInSection section: Int) -> Int;
    func dataSource(objectAt index: Int) -> Todo?;
    func viewDidAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func search(text: String?);
    func delete(todo: Todo);
    func save(todo: Todo);
}


protocol TodoListInteractorOutput: AnyObject {
    func updateTableView();
    func update(total: Int);
    func showError(_ error: Error);
    func endEditing(_ force: Bool);
    func insert(tableView rows: [IndexPath]);
    func delete(tableView rows: [IndexPath]);
    func update(tableView rows: [IndexPath]);
}


class TodoListInteractor: TodoListInteractorInput {
    
    weak var presenter: TodoListInteractorOutput?;
    var datasource: TodoDataSourceInput?;
    private var isViewAppeared: Bool;
    private var dataSourceUpdates: DataSourceUpdates?;
    
    init(presenter: TodoListInteractorOutput?, datasource: TodoDataSourceInput?) {
        self.isViewAppeared = false;
        self.presenter = presenter;
        self.datasource = datasource;
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.isViewAppeared = true;
        self.reloadData();
        self.updateTotal();
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.isViewAppeared = false;
    }
    
    func dataSource(numberOfRowsInSection section: Int) -> Int {
        self.datasource?.dataSource(numberOfRowsInSection: section) ?? 0;
    }
    
    func dataSource(objectAt index: Int) -> Todo? {
        self.datasource?.dataSource(objectAt: index);
    }
    
    private func databaseErrorHandler(_ error: Error?) {
        guard let error else {
            return;
        }
        OperationQueue.main.addOperation {
            self.presenter?.showError(error);
        }
    }
    
    func delete(todo: Todo) {
        Database.shared.delete(objects: [todo], completionHandler: self.databaseErrorHandler);
    }
    
    func save(todo: Todo) {
        Database.shared.save(todos: [todo], completionHandler: self.databaseErrorHandler);
    }
    
    func search(text: String?) {
        do {
            try self.datasource?.search(text: text);
        }
        catch {
            self.presenter?.showError(error);
        }
    }
    
    private func reloadData() {
        guard let datasource = self.datasource else {
            return;
        }
        guard datasource.isFetched else {
            self.fetchData();
            return;
        }
        self.update(tableView: self.dataSourceUpdates);
        self.dataSourceUpdates = nil;
    }
    
    private func fetchData() {
        do {
            try self.datasource?.fetch();
        }
        catch {
            self.presenter?.showError(error);
        }
    }
    
    private func update(tableView updates: DataSourceUpdates?) {
        guard let presenter = self.presenter else {
            return;
        }
        guard let updates, updates.moved.isEmpty else {
            presenter.updateTableView();
            return;
        }
        switch (updates.inserted.count, updates.deleted.count, updates.updated.count) {
        case (0, 0, 0):
            presenter.updateTableView();
        case (_, 0, 0):
            presenter.insert(tableView: updates.inserted);
        case (0, _, 0):
            presenter.delete(tableView: updates.deleted);
        case (0, 0, _):
            presenter.update(tableView: updates.updated);
        default:
            presenter.updateTableView();
        }
    }
    
    private func updateTotal() {
        let count = self.dataSource(numberOfRowsInSection: 0);
        self.presenter?.update(total: count);
    }
    
}


extension TodoListInteractor: TodoDataSourceOutput {

    func didChangeContent(updates: DataSourceUpdates?) {
        guard self.isViewAppeared else {
            self.dataSourceUpdates = updates;
            return;
        }
        self.update(tableView: updates);
        self.updateTotal();
    }
    
}
