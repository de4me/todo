//
//  TodoListPopupConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class TodoListPopupConfigurator: AnyObject {
 
    static func configure(view: TodoListPopupViewInput) -> TodoListPopupViewOutput & TodoListPopupPresenterProtocol {
        let presenter = TodoListPopupPresenter(view: view, interactor: nil, router: nil);
        let interactor = TodoListPopupInteractor(presenter: presenter);
        let router = TodoListPopupRouter(presenter: presenter);
        presenter.interactor = interactor;
        presenter.router = router;
        return presenter;
    }
    
}
