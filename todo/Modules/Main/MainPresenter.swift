//
//  MainPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol MainPresenterProtocol: AnyObject {
    var view: MainViewInput? { get set }
    var interactor: MainInteractorInput? { get set }
}


class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewInput?;
    var interactor: MainInteractorInput?;
    
    init(view: MainViewInput?, interactor: MainInteractorInput?) {
        self.view = view;
        self.interactor = interactor;
    }
    
}


extension MainPresenter: MainViewOutput {
    
    func viewWillAppear(_ animated: Bool) {
        self.interactor?.viewWillAppear(animated);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.interactor?.viewWillDisappear(animated);
    }
    
    func navigationController(_ navigationController: NavigationControllerProtocol, willShow viewController: NavigationProtocol?, animated: Bool) {
        self.interactor?.navigationController(navigationController, willShow: viewController, animated: animated);
    }
    
}


extension MainPresenter: MainInteractorOutput {
    
}
