//
//  MainPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol MainPresenterProtocol: AnyObject {
    var view: MainViewInput? { get set }
    var interator: MainInteratorInput? { get set }
}


class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewInput?;
    var interator: MainInteratorInput?;
    
    init(view: MainViewInput?, interator: MainInteratorInput?) {
        self.view = view;
        self.interator = interator;
    }
    
}


extension MainPresenter: MainViewOutput {
    
    func viewWillAppear(_ animated: Bool) {
        self.interator?.viewWillAppear(animated);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.interator?.viewWillDisappear(animated);
    }
    
    func navigationController(_ navigationController: NavigationControllerProtocol, willShow viewController: NavigationProtocol?, animated: Bool) {
        self.interator?.navigationController(navigationController, willShow: viewController, animated: animated);
    }
    
}
