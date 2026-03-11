//
//  TodoListConfigurator.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


class TodoListConfigurator {
    
    static func configure(view: TodoListViewInput) -> TodoListViewOutput & TodoListPresenterProtocol {
        let presenter = TodoListPresenter(view: view, interator: nil, router: nil);
        let interator = TodoListInterator(presenter: presenter, datasource: nil);
        let router = TodoListRouter(presenter: presenter);
        let datasource = TodoDataSource(output: interator);
        interator.datasource = datasource;
        presenter.interator = interator;
        presenter.router = router;
        return presenter;
    }
    
}
