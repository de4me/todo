//
//  TodoEditRouter.swift
//  todo
//
//  Created by DE4ME on 11.03.2026.
//

import Foundation;


protocol TodoEditRouterInput {
    
    func close();
    
}


fileprivate class TodoEditRouter: TodoEditRouterInput {
    
    private weak var presenter: TodoEditPresenterProtocol!;
    
    init(presenter: TodoEditPresenterProtocol) {
        self.presenter = presenter;
    }
    
    func close() {
        
    }
    
}


class TodoEditRouterConfigurator {
    
    static func configure(presenter: TodoEditPresenterProtocol) -> TodoEditRouterInput {
        TodoEditRouter(presenter: presenter);
    }
    
}
