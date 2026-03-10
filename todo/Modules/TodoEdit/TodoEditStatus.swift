//
//  TodoEditStatus.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol TodoEditStatusInput: AnyObject {
    var todo: Todo? { get set }
}


class TodoEditStatus: AnyObject, TodoEditStatusInput {
    
    var todo: Todo?;
    
}
