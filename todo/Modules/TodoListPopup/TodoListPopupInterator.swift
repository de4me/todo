//
//  TodoListPopupInterator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


protocol TodoListPopupInteratorInput: AnyObject {
    func viewDidLoad();
    func viewWillAppear(_ animated: Bool);
    func viewDidAppear(_ animated: Bool);
    func setValue(popupInfo: TodoPopupInfo);
    func todo() -> Todo?;
}


class TodoListPopupInterator: AnyObject {
    
    weak var presenter: TodoListPopupPresenterProtocol?;
    private var popup: TodoPopupInfo?;
    
    init(presenter: TodoListPopupPresenterProtocol?) {
        self.presenter = presenter;
    }
    
}


extension TodoListPopupInterator: TodoListPopupInteratorInput {
    
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
