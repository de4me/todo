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
    func setValue(popupInfo: TodoPopupInfo);
    func todo() -> Todo?;
}


protocol TodoListPopupInteractorOutput: AnyObject {
    func animatePopup();
    func updateTodo(_ todo: Todo?);
    func updatePopupViewAlpha(_ alpha: CGFloat);
    func updateTopLayoutConstraint(_ value: CGFloat);
}


class TodoListPopupInteractor: AnyObject {
    
    weak var presenter: TodoListPopupInteractorOutput?;
    private var popup: TodoPopupInfo?;
    
    init(presenter: TodoListPopupInteractorOutput?) {
        self.presenter = presenter;
    }
    
}


extension TodoListPopupInteractor: TodoListPopupInteractorInput {
    
    func viewDidLoad() {
        self.presenter?.updatePopupViewAlpha(0);
    }
    
    func viewWillAppear(_ animated: Bool) {
        guard let presenter = self.presenter,
              let popup = self.popup
        else {
            return;
        }
        presenter.updateTodo(popup.todo);
        presenter.updateTopLayoutConstraint(popup.offset);
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.presenter?.animatePopup();
    }
    
    func setValue(popupInfo: TodoPopupInfo) {
        self.popup = popupInfo;
    }
    
    func todo() -> Todo? {
        self.popup?.todo;
    }

}
