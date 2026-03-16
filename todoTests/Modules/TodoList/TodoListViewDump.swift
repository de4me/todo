//
//  TodoListViewDump.swift
//  todo
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;


class TodoListViewDump: TodoListViewInput {
    
    var route: String?;
    var total: String?;
    var error: Error?;
    var valueEndEditing = false;
    var valueUpdateTableView = false;
    var setErrorExpectation: XCTestExpectation = .init(description: "Set error");
    var alertMessage: String?;
    var alertButton: String?;
    var insertIndexPaths: [IndexPath]?;
    var deleteinsertIndexPaths: [IndexPath]?;
    var updateIndexPaths: [IndexPath]?;
    
    func performSegue(withIdentifier indentifier: String, sender: Any?) {
        self.route = indentifier;
    }
    
    func updateTableView() {
        self.valueUpdateTableView = true;
    }
    
    func update(total: String) {
        self.total = total;
    }
    
    func showError(_ error: any Error) {
        self.error = error;
        self.setErrorExpectation.fulfill();
    }
    
    func endEditing(_ force: Bool) {
        self.valueEndEditing = true;
    }
    
    func showAlert(message: String, button title: String, destructive: Bool, actionSheeet: Bool, handler: @escaping (Any) -> Void) {
        self.alertMessage = message;
        self.alertButton = title;
    }
    
    func insert(tableView rows: [IndexPath]) {
        self.insertIndexPaths = rows;
    }
    
    func delete(tableView rows: [IndexPath]) {
        self.deleteinsertIndexPaths = rows;
    }
    
    func update(tableView rows: [IndexPath]) {
        self.updateIndexPaths = rows;
    }
    
    func showShare(text: String) {
        
    }
}
