//
//  TodoListConfigurator.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


class TodoListConfigurator {
    
    static func configure(view: TodoListViewInput) -> TodoListViewOutput & TodoListInteractorOutput & TodoListRouterOutput &  TodoListPresenterProtocol {
        let presenter = TodoListPresenter(view: view, interactor: nil, router: nil);
        let interactor = TodoListInteractor(presenter: presenter, datasource: nil);
        let router = TodoListRouter(presenter: presenter);
        let datasource = TodoDataSource(output: interactor);
        interactor.datasource = datasource;
        presenter.interactor = interactor;
        presenter.router = router;
        return presenter;
    }
    
}
