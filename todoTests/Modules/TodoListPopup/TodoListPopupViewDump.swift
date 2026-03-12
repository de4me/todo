//
//  TodoListPopupViewDump.swift
//  todo
//
//  Created by DE4ME on 12.03.2026.
//

import CoreGraphics;
@testable import todo;


class TodoListPopupViewDump: TodoListPopupViewInput {
    
    var route: String?;
    var todo: Todo?;
    var popupViewAlpha: CGFloat = .nan;
    var topLayoutConstraint: CGFloat = .nan;
    var popupAnimated: Bool = false;
    
    func updateTodo(_ todo: todo.Todo?) {
        self.todo = todo;
    }
    
    func updatePopupViewAlpha(_ alpha: CGFloat) {
        self.popupViewAlpha = alpha;
    }
    
    func updateTopLayoutConstraint(_ value: CGFloat) {
        self.topLayoutConstraint = value;
    }
    
    func animatePopup() {
        self.popupAnimated = true;
    }
    
    
    func performSegue(withIdentifier identifier: String, sender: Any?) {
        self.route = identifier;
    }
    
}
