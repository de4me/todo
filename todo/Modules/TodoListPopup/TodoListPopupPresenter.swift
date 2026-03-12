//
//  TodoListPopupPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoListPopupPresenterProtocol: AnyObject {
    var view: TodoListPopupViewInput? { get set }
    var interactor: TodoListPopupInteractorInput? { get set }
    var router: TodoListPopupRouterInput? { get set }
}


class TodoListPopupPresenter: TodoListPopupPresenterProtocol {
    
    weak var view: TodoListPopupViewInput?;
    var interactor: TodoListPopupInteractorInput?;
    var router: TodoListPopupRouterInput?;
    
    init(view: TodoListPopupViewInput?, interactor: TodoListPopupInteractorInput?, router: TodoListPopupRouterInput?) {
        self.view = view;
        self.interactor = interactor;
        self.router = router;
    }
    
}


extension TodoListPopupPresenter: TodoListPopupViewOutput {
    
    func viewDidLoad() {
        self.interactor?.viewDidLoad();
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.interactor?.viewWillAppear(animated);
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.interactor?.viewDidAppear(animated);
    }
    
    func setValue(popupInfo: TodoPopupInfo?) {
        guard let popupInfo else {
            return;
        }
        self.interactor?.setValue(popupInfo: popupInfo);
    }
    
    func close() {
        self.router?.close();
    }
    
    func edit() {
        guard let todo = self.interactor?.todo() else {
            return;
        }
        self.router?.edit(todo: todo);
    }
    
    func delete() {
        guard let todo = self.interactor?.todo() else {
            return;
        }
        self.router?.delete(todo: todo);
    }
    
    func share() {
        guard let todo = self.interactor?.todo() else {
            return;
        }
        self.router?.share(todo: todo);
    }
    
}


extension TodoListPopupPresenter: TodoListPopupInteractorOutput {
    
    func updateTodo(_ todo: Todo?) {
        self.view?.updateTodo(todo);
    }
    
    func updatePopupViewAlpha(_ alpha: CGFloat) {
        self.view?.updatePopupViewAlpha(alpha);
    }
    
    func updateTopLayoutConstraint(_ value: CGFloat) {
        self.view?.updateTopLayoutConstraint(value);
    }
    
    func animatePopup() {
        self.view?.animatePopup();
    }
    
}


extension TodoListPopupPresenter: TodoListPopupRouterOutput {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
}
