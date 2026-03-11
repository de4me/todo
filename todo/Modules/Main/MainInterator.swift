//
//  MainInterator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol MainInteratorInput: AnyObject {
    func viewWillAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func navigationController(_ navigationController: NavigationControllerProtocol, willShow viewController: NavigationProtocol?, animated: Bool);
}


protocol MainInteratorOutput: AnyObject {
    
}


class MainInterator: MainInteratorInput {
    
    weak var presenter: MainPresenterProtocol?;
    
    init(presenter: MainPresenterProtocol?) {
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


extension MainInterator: MainInteratorOutput {
    
}
