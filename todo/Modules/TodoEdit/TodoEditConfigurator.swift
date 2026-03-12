//
//  TodoEditConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class TodoEditConfigurator: AnyObject {
    
    static func configure(view: TodoEditViewInput) -> TodoEditViewOutput & TodoEditInteractorOutput & TodoEditRouterOutput & TodoEditPresenterProtocol {
        let presenter = TodoEditPresenter(view: view, interactor: nil, router: nil);
        let interactor = TodoEditInteractor(presenter: presenter);
        let router = TodoEditRouter(presenter: presenter);
        presenter.interactor = interactor;
        presenter.router = router;
        return presenter;
    }
    
}
