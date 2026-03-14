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
        let close = UIAlertAction(title: String(localized: "close"), style: .default);
        alert.addAction(close);
        self.present(alert, animated: true);
    }
    
    func showAlert(message: String, button title: String, destructive: Bool = false, actionSheeet: Bool = false, handler: @escaping (Any) -> Void) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: actionSheeet ? .actionSheet : .alert);
        let close = UIAlertAction(title: String(localized: "close"), style: .cancel);
        let action = UIAlertAction(title: title, style: destructive ? .destructive : .default, handler: handler);
        controller.addAction(close);
        controller.addAction(action);
        self.present(controller, animated: true);
    }
    
    func showShare(text: String) {
        let controller = UIActivityViewController(activityItems: [text], applicationActivities: nil);
        self.present(controller, animated: true, completion: nil);
    }
    
}
