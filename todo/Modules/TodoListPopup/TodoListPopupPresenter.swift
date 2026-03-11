//
//  TodoListPopupPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoListPopupPresenterProtocol: AnyObject {
    var view: TodoListPopupViewInput? { get set }
    var interator: TodoListPopupInteratorInput? { get set }
    var router: TodoListPopupRouterInput? { get set }
    func updateTodo(_ todo: Todo?);
    func updatePopupViewAlpha(_ alpha: CGFloat);
    func updateTopLayoutConstraint(_ value: CGFloat);
    func animatePopup();
    func performSegue(withIdentifier: String, sender: Any?);
}


class TodoListPopupPresenter: TodoListPopupPresenterProtocol {
    
    weak var view: TodoListPopupViewInput?;
    var interator: TodoListPopupInteratorInput?;
    var router: TodoListPopupRouterInput?;
    
    init(view: TodoListPopupViewInput?, interator: TodoListPopupInteratorInput?, router: TodoListPopupRouterInput?) {
        self.view = view;
        self.interator = interator;
        self.router = router;
    }
    
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
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
}


extension TodoListPopupPresenter: TodoListPopupViewOutput {
    
    func viewDidLoad() {
        self.interator?.viewDidLoad();
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.interator?.viewWillAppear(animated);
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.interator?.viewDidAppear(animated);
    }
    
    func setValue(popupInfo: TodoPopupInfo?) {
        guard let popupInfo else {
            return;
        }
        self.interator?.setValue(popupInfo: popupInfo);
    }
    
    func close() {
        self.router?.close();
    }
    
    func edit() {
        guard let todo = self.interator?.todo() else {
            return;
        }
        self.router?.edit(todo: todo);
    }
    
    func delete() {
        guard let todo = self.interator?.todo() else {
            return;
        }
        self.router?.delete(todo: todo);
    }
    
    func share() {
        guard let todo = self.interator?.todo() else {
            return;
        }
        self.router?.share(todo: todo);
    }
    
}
