//
//  TodoEditViewController.swift
//  todo
//
//  Created by DE4ME on 07.03.2026.
//

import UIKit;


protocol TodoEditViewInput: AnyObject {
    func updateTodo(todo: Todo?);
    func getValueEditResult() -> TodoEditResult;
}


protocol TodoEditViewOutput: AnyObject {
    func viewWillAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func setValue(todo: Todo?);
}


class TodoEditViewController: KeyboardViewController {
    
    @IBOutlet var titleTextView: TextView!;
    @IBOutlet var subtitleTextView: TextView!;
    @IBOutlet var createdDateLabel: UILabel!;
    
    private var presenter: TodoEditViewOutput!;
    
    var todo: Todo?;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.presenter = TodoEditConfigurator.configure(view: self);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.presenter.setValue(todo: self.todo);
        self.presenter.viewWillAppear(animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.presenter.viewWillDisappear(animated);
    }
    
}


extension TodoEditViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        switch text {
        case "\n":
            textView.resignFirstResponder();
            return false;
        default:
            return true;
        }
    }
    
}



extension TodoEditViewController: TodoEditViewInput {
    
    func updateTodo(todo: Todo?) {
        guard let todo else {
            return;
        }
        self.titleTextView.text = todo.title.nilIfEmpty();
        self.subtitleTextView.text = todo.subtitle.nilIfEmpty();
        self.createdDateLabel.text = todo.localizedCreatedDate;
    }
    
    func getValueEditResult() -> TodoEditResult {
        let title = self.titleTextView.isPlaceholder ? nil : self.titleTextView.text?.trimmed();
        let subtitle = self.subtitleTextView.isPlaceholder ? nil : self.subtitleTextView.text?.trimmed();
        return TodoEditResult(title: title, subtitle: subtitle);
    }
    
}
