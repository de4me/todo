//
//  TodoListPopupViewController.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;



protocol TodoListPopupViewInput: AnyObject {
    func updateTodo(_ todo: Todo?);
    func updatePopupViewAlpha(_ alpha: CGFloat);
    func updateTopLayoutConstraint(_ value: CGFloat);
    func animatePopup();
    func performSegue(withIdentifier: String, sender: Any?);
    func getValuePopupInfo() -> TodoPopupInfo?;
}


protocol TodoListPopupViewOutput: AnyObject {
    func viewDidLoad();
    func viewWillAppear(_ animated: Bool);
    func viewDidAppear(_ animated: Bool);
    func animatePopup();
    func close();
    func edit();
    func delete();
    func share();
}


class TodoListPopupViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!;
    @IBOutlet var subtitleLabel: UILabel!;
    @IBOutlet var dateLabel: UILabel!;
    @IBOutlet var completedButton: UIButton!;
    @IBOutlet var rootView: UIView!;
    
    @IBOutlet var popupView: UIView!;
    
    @IBOutlet var unactiveLayoutConstarint: [NSLayoutConstraint]!;
    
    @IBOutlet var topLayoutConstraint: NSLayoutConstraint!;
    
    var popupInfo: TodoPopupInfo?;
    
    private var presenter: TodoListPopupViewOutput!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.presenter = TodoListPopupConfigurator.configure(view: self);
        self.presenter.viewDidLoad();
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.presenter.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.presenter.viewDidAppear(animated);
    }
    
    @IBAction func closeClick(_ sender: Any) {
        self.presenter.close();
    }
    
    @IBAction func editClick(_ sender: Any) {
        self.presenter.edit();
    }
    
    @IBAction func deleteClick(_ sender: Any) {
        self.presenter.delete();
    }
    
    @IBAction func shareClick(_ sender: Any) {
        self.presenter.share();
    }

}


extension TodoListPopupViewController: TodoListPopupViewInput {
    
    func updatePopupViewAlpha(_ alpha: CGFloat) {
        self.popupView.alpha = alpha;
    }
    
    func updateTodo(_ todo: Todo?) {
        guard let todo else {
            return;
        }
        self.titleLabel.isHighlighted = todo.isCompleted;
        self.titleLabel.text = todo.title;
        self.subtitleLabel.isHighlighted = todo.isCompleted;
        self.subtitleLabel.text = todo.subtitle;
        self.dateLabel.text = todo.localizedCreatedDate;
        self.completedButton.isSelected = todo.isCompleted;
    }
    
    func updateTopLayoutConstraint(_ value: CGFloat) {
        self.topLayoutConstraint.constant = value;
    }
    
    func animatePopup() {
        UIView.animate(withDuration: 1/3, delay: 0, options: .curveEaseInOut) {
            self.unactiveLayoutConstarint.forEach { $0.isActive = true; }
            self.completedButton.isHidden = true;
            self.popupView.alpha = 1;
            self.view.layoutIfNeeded();
        }
    }
    
    func getValuePopupInfo() -> TodoPopupInfo? {
        self.popupInfo;
    }

}


extension TodoListPopupViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let point = gestureRecognizer.location(in: self.rootView);
        return self.rootView.subview(at: point, checkUserInteraction: true) == nil;
    }
    
}
