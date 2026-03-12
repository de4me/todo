//
//  MainInteractor.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol MainInteractorInput: AnyObject {
    var presenter: MainInteractorOutput? { get set }
    func viewWillAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func navigationController(_ navigationController: NavigationControllerProtocol, willShow viewController: NavigationProtocol?, animated: Bool);
}


protocol MainInteractorOutput: AnyObject {
    
}


class MainInteractor: MainInteractorInput {
    
    weak var presenter: MainInteractorOutput?;
    
    init(presenter: MainInteractorOutput?) {
        self.presenter = presenter
    }
    
    func navigationController(_ navigationController: NavigationControllerProtocol, willShow viewController: NavigationProtocol?, animated: Bool) {
        let hidden = viewController?.hideNavigationBar ?? false;
        guard hidden != navigationController.isNavigationBarHidden else {
            return;
        }
        navigationController.setNavigationBarHidden(hidden, animated: animated);
    }
    
    func viewWillAppear(_ animated: Bool) {
        UpdateManager.shared.start();
    }
    
    func viewWillDisappear(_ animated: Bool) {
        UpdateManager.shared.stop();
    }
    
}
