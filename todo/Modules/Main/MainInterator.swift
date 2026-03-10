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


fileprivate class MainInterator: MainInteratorInput {
    
    private weak var presenter: MainViewOutput!;
    
    init(presenter: MainViewOutput) {
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
        //TODO: Update start
    }
    
    func viewWillDisappear(_ animated: Bool) {
        //TODO: Update stop
    }
    
}


extension MainInterator: MainInteratorOutput {
    
}


class MainInteratorConfigurator {
    
    static func configure(presenter: MainViewOutput) -> MainInteratorInput & MainInteratorOutput {
        MainInterator(presenter: presenter);
    }
    
}
