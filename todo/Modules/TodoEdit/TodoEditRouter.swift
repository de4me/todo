//
//  TodoEditRouter.swift
//  todo
//
//  Created by DE4ME on 11.03.2026.
//

import Foundation;


protocol TodoEditRouterInput {
    var presenter: TodoEditRouterOutput? { get set }
    func close();
}


protocol TodoEditRouterOutput: AnyObject {
    func performSegue(withIdentifier: String, sender: Any?);
}


class TodoEditRouter: TodoEditRouterInput {
    
    weak var presenter: TodoEditRouterOutput?;
    
    enum SegueName: String, CaseIterable {
        case close;
    }
    
    struct Name {
        static let close = SegueName.close.rawValue;
    }
    
    init(presenter: TodoEditRouterOutput) {
        self.presenter = presenter;
    }
    
    func close() {
        self.presenter?.performSegue(withIdentifier: Name.close, sender: nil);
    }
    
}
