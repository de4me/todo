//
//  MainConfigurator.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol MainConfiguratorProtocol: AnyObject {
    var delegate: UINavigationControllerDelegate? { get set }
}


class MainConfigurator: AnyObject {
    
    static func configure(view: MainConfiguratorProtocol & MainViewInput & UINavigationControllerDelegate) -> MainViewOutput {
        let presenter = NavigationPresenterConfigurator.configure(view: view);
        view.delegate = view;
        return presenter;
    }
    
}
