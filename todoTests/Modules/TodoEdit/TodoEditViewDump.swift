//
//  TodoEditViewDump.swift
//  todo
//
//  Created by DE4ME on 12.03.2026.
//

@testable import todo;


class TodoEditViewDump: TodoEditViewInput {
    
    var route: String?;
    var todo: Todo?;
    var error: Error?;
    var updateTodo: Todo?;
    
    let editTitle = "Edit Title";
    let editSubtitle = "Edit Subtitle";
    
    func performSegue(withIdentifier indentifier: String, sender: Any?) {
        self.route = indentifier;
    }
    
    func updateTodo(todo: todo.Todo?) {
        self.updateTodo = todo;
    }
    
    func getValueEditResult() -> TodoEditResult {
        .init(title: self.editTitle, subtitle: self.editSubtitle);
    }
    
    func getValueTodo() -> todo.Todo? {
        self.todo;
    }
    
    func showError(_ error: any Error) {
        self.error = error;
    }
    
}
