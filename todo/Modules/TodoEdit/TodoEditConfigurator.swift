//
//  TodoEditConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


class TodoEditConfigurator: AnyObject {
    
    static func configure(view: TodoEditViewInput) -> TodoEditViewOutput {
        let presenter = TodoEditPresenter.init(view: view, interactor: nil, router: nil);
        let interator = TodoEditInterator(presenter: presenter);
        let router = TodoEditRouter(presenter: presenter);
        presenter.interactor = interator;
        presenter.router = router;
        return presenter;
    }
    
}
