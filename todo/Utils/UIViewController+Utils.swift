//
//  UIViewController+Utils.swift
//  todo
//
//  Created by DE4ME on 11.03.2026.
//

import UIKit;


extension UIViewController {
    
    func showError(_ error: any Error) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert);
        let close = UIAlertAction(title: String(localizedString: "close"), style: .default);
        alert.addAction(close);
        self.present(alert, animated: true);
    }
    
}
