//
//  TodoListPopupPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoListPopupPresenterProtocol: AnyObject {
    func updateTodo(_ todo: Todo?);
    func updatePopupViewAlpha(_ alpha: CGFloat);
    func updateTopLayoutConstraint(_ value: CGFloat);
    func animatePopup();
    func performSegue(withIdentifier: String, sender: Any?);
}


fileprivate class TodoListPopupPresenter: AnyObject {
    
    private weak var view: TodoListPopupViewInput!;
    private var interator: TodoListPopupInteratorInput!;
    private var router: TodoListPopupRouterInput!;
    
    init(view: TodoListPopupViewInput) {
        self.view = view;
        self.interator = TodoListPopupInteratorConfigurator.configure(presenter: self);
        self.router = TodoListPopupRouterConfigurator.configure(presenter: self);
    }
    
}


extension TodoListPopupPresenter: TodoListPopupViewOutput {
    
    func viewDidLoad() {
        self.interator.viewDidLoad();
    }
    
    func viewWillAppear(_ animated: Bool) {
        self.interator.viewWillAppear(animated);
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.interator.viewDidAppear(animated);
    }
    
    func setValue(popupInfo: TodoPopupInfo?) {
        guard let popupInfo else {
            return;
        }
        self.interator.setValue(popupInfo: popupInfo);
    }
    
    func close() {
        self.router.close();
    }
    
    func edit() {
        self.router.edit(todo: self.interator.todo());
    }
    
    func delete() {
        self.router.delete(todo: self.interator.todo());
    }
    
    func share() {
        self.router.share(todo: self.interator.todo());
    }
    
}


extension TodoListPopupPresenter: TodoListPopupPresenterProtocol {
    
    func updateTodo(_ todo: Todo?) {
        self.view.updateTodo(todo);
    }
    
    func updatePopupViewAlpha(_ alpha: CGFloat) {
        self.view.updatePopupViewAlpha(alpha);
    }
    
    func updateTopLayoutConstraint(_ value: CGFloat) {
        self.view.updateTopLayoutConstraint(value);
    }
    
    func animatePopup() {
        self.view.animatePopup();
    }
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
}


class TodoListPopupPresenterConfigurator {
    
    static func configure(view: TodoListPopupViewInput) -> TodoListPopupPresenterProtocol & TodoListPopupViewOutput {
        TodoListPopupPresenter(view: view);
    }
    
}
