//
//  TodoListPopupStatus.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoListPopupStatusInput: AnyObject {
    var todo: Todo? { get set }
    var offset: CGFloat { get set }
}


class TodoListPopupStatus: TodoListPopupStatusInput {
    
    var todo: Todo?;
    var offset: CGFloat;
    
    init() {
        self.todo = nil;
        self.offset = 0;
    }
    
}
