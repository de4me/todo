//
//  TodoListPopupConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class TodoListPopupConfigurator: AnyObject {
 
    static func configure(view: TodoListPopupViewInput) -> TodoListPopupViewOutput & TodoListPopupPresenterProtocol {
        let presenter = TodoListPopupPresenter(view: view, interator: nil, router: nil);
        let interator = TodoListPopupInterator(presenter: presenter);
        let router = TodoListPopupRouter(presenter: presenter);
        presenter.interator = interator;
        presenter.router = router;
        return presenter;
    }
    
}
