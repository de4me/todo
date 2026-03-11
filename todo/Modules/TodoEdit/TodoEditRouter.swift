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
    
    private weak var presenter: TodoEditPresenterProtocol?;
    
    enum SegueName: String, CaseIterable {
        case close;
    }
    
    struct Name {
        static let close = SegueName.close.rawValue;
    }
    
    init(presenter: TodoEditPresenterProtocol) {
        self.presenter = presenter;
    }
    
    func close() {
        self.presenter?.performSegue(withIdentifier: Name.close, sender: nil);
    }
    
}


class TodoEditRouterConfigurator {
    
    static func configure(presenter: TodoEditPresenterProtocol) -> TodoEditRouterInput {
        TodoEditRouter(presenter: presenter);
    }
    
}
