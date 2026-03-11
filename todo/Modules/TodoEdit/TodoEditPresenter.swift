//
//  TodoEditPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoEditPresenterProtocol: AnyObject {
    func update(todo: Todo?);
    func getValueEditResult() -> TodoEditResult;
}


fileprivate class TodoEditPresenter: AnyObject {
    
    private weak var view: TodoEditViewInput!;
    private var interactor: TodoEditInteratorInput!;
    
    init(view: TodoEditViewInput) {
        self.view = view
        self.interactor = TodoEditInteratorConfigurator.configure(presenter: self);
    }
    
}


extension TodoEditPresenter: TodoEditViewOutput {
    
    func setValue(todo: Todo?) {
        let todo = todo ?? Todo();
        self.interactor.setValue(todo: todo);
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.interactor.viewWillAppear(animated);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.interactor.viewWillDisappear(animated);
    }
    
}


extension TodoEditPresenter: TodoEditPresenterProtocol {
    
    func update(todo: Todo?) {
        self.view.updateTodo(todo: todo);
    }
    
    func getValueEditResult() -> TodoEditResult {
        self.view.getValueEditResult();
    }
    
}


class TodoEditPresenterConfigurator {
    
    static func configure(view: TodoEditViewInput) -> TodoEditPresenterProtocol & TodoEditViewOutput {
        TodoEditPresenter(view: view);
    }
    
}
