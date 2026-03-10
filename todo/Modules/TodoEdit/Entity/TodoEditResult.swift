//
//  TodoEditResult.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


struct TodoEditResult {
    
    let title: String;
    let subtitle: String;
    
    var isEmpty: Bool {
        self.title.isEmpty && self.subtitle.isEmpty;
    }
    
    init(title: String?, subtitle: String?) {
        self.title = title ?? "";
        self.subtitle = subtitle ?? "";
    }
    
}


extension Todo {
    
    func isEqual(to other: TodoEditResult) -> Bool {
        self.title == other.title && self.subtitle == other.subtitle;
    }
    
}
