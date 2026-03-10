//
//  TodoPopupInfo.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


struct TodoPopupInfo {
    
    let todo: Todo?;
    let offset: CGFloat;
    
    init(todo: Todo?, offset: CGFloat) {
        self.todo = todo;
        self.offset = offset;
    }
    
}
