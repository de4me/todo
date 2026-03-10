//
//  MainPresenter.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol MainPresenterProtocol: AnyObject {

}


fileprivate class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainViewInput!;
    private var interator: MainInteratorInput!;
    
    init(view: MainViewInput) {
        self.view = view
        self.interator = MainInteratorConfigurator.configure(presenter: self);
    }
    
}


extension MainPresenter: MainViewOutput {
    
    func viewWillAppear(_ animated: Bool) {
        self.interator.viewWillAppear(animated);
    }
    
    func viewWillDisappear(_ animated: Bool) {
        self.interator.viewWillDisappear(animated);
    }
    
    func navigationController(_ navigationController: NavigationControllerProtocol, willShow viewController: NavigationProtocol?, animated: Bool) {
        self.interator.navigationController(navigationController, willShow: viewController, animated: animated);
    }
    
}


class NavigationPresenterConfigurator {
    
    static func configure(view: MainViewInput) -> MainPresenterProtocol & MainViewOutput {
        MainPresenter(view: view);
    }
    
}
