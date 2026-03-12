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
    
    func close() {
        self.router?.close();
    }
    
    func edit() {
        guard let info = self.getValuePopupInfo(),
              let todo = info.todo
        else {
            return;
        }
        self.router?.edit(todo: todo);
    }
    
    func delete() {
        guard let info = self.getValuePopupInfo(),
              let todo = info.todo
        else {
            return;
        }
        self.router?.delete(todo: todo);
    }
    
    func share() {
        guard let info = self.getValuePopupInfo(),
              let todo = info.todo
        else {
            return;
        }
        self.router?.share(todo: todo);
    }
    
}


extension TodoListPopupPresenter: TodoListPopupInteractorOutput {
    
    func update(todo: Todo?) {
        guard let todo else {
            return;
        }
        self.view?.update(todo: todo);
    }
    
    func update(popupViewAlpha alpha: CGFloat) {
        self.view?.update(popupViewAlpha: alpha);
    }
    
    func update(topLayoutConstraint value: CGFloat) {
        self.view?.update(topLayoutConstraint: value);
    }
    
    func animatePopup() {
        self.view?.animatePopup();
    }
    
    func getValuePopupInfo() -> TodoPopupInfo? {
        self.view?.getValuePopupInfo()
    }
    
}


extension TodoListPopupPresenter: TodoListPopupRouterOutput {
    
    func performSegue(withIdentifier: String, sender: Any?) {
        self.view?.performSegue(withIdentifier: withIdentifier, sender: sender);
    }
    
}
