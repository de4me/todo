//
//  TodoListPopupInteractor.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoListPopupInteractorInput: AnyObject {
    var presenter: TodoListPopupInteractorOutput? { get set }
    func viewDidLoad();
    func viewWillAppear(_ animated: Bool);
    func viewDidAppear(_ animated: Bool);
}


protocol TodoListPopupInteractorOutput: AnyObject {
    func animatePopup();
    func update(todo: Todo?);
    func update(popupViewAlpha alpha: CGFloat);
    func update(topLayoutConstraint value: CGFloat);
    func getValuePopupInfo() -> TodoPopupInfo?;
}


class TodoListPopupInteractor: AnyObject {
    
    weak var presenter: TodoListPopupInteractorOutput?;
    
    init(presenter: TodoListPopupInteractorOutput?) {
        self.presenter = presenter;
    }
    
}


extension TodoListPopupInteractor: TodoListPopupInteractorInput {
    
    func viewDidLoad() {
        self.presenter?.update(popupViewAlpha: 0);
    }
    
    func viewWillAppear(_ animated: Bool) {
        guard let presenter = self.presenter,
              let popup = self.presenter?.getValuePopupInfo()
        else {
            return;
        }
        presenter.update(todo: popup.todo);
        presenter.update(topLayoutConstraint: popup.offset);
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.presenter?.animatePopup();
    }

}
