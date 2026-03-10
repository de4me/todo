//
//  MainViewController.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol MainViewInput: AnyObject {
    
}


protocol MainViewOutput: AnyObject {
    func viewWillAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func navigationController(_ navigationController: NavigationControllerProtocol, willShow viewController: NavigationProtocol?, animated: Bool);
}


class MainViewController: UINavigationController, MainConfiguratorProtocol {
    
    private var presenter: MainViewOutput!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.presenter = MainConfigurator.configure(view: self);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.presenter.viewWillAppear(animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.presenter.viewWillDisappear(animated);
    }

}


extension MainViewController: MainViewInput {
    
}


extension MainViewController:  UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.presenter.navigationController(navigationController, willShow: viewController as? NavigationProtocol, animated: animated);
    }
    
}
