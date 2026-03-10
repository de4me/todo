//
//  DBTodo.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import CoreData;


extension DBTodo {
    
    var isComplited: Bool {
        self.completedDate != nil;
    }
    
}


extension DBTodo {
    
    func assign(todo: Todo) {
        if self.title != todo.title {
            self.title = todo.title;
        }
        if self.subtitle != todo.subtitle {
            self.subtitle = todo.subtitle;
        }
        if self.createdDate != todo.createdDate {
            self.createdDate = todo.createdDate;
        }
        if self.completedDate != todo.completedDate {
            self.completedDate = todo.completedDate;
        }
    }
    
}


extension Todo {
    
    init(db: DBTodo) {
        self.id = db.objectID;
        self.title = db.title ?? "";
        self.subtitle = db.subtitle ?? "";
        self.createdDate = db.createdDate ?? Date();
        self.completedDate = db.completedDate;
    }
    
}
