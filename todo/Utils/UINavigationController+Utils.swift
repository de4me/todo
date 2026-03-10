//
//  UINavigationController+Utils.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol NavigationControllerProtocol: AnyObject {
    var isNavigationBarHidden: Bool { get }
    func setNavigationBarHidden(_ hidden: Bool, animated: Bool);
}


extension UINavigationController: NavigationControllerProtocol {
    
}
