//
//  TodoListViewController.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


protocol TodoListViewInput: AnyObject {
    func performSegue(withIdentifier: String, sender: Any?);
    func updateTableView();
    func update(total: String);
    func showError(_ error: Error);
    func endEditing(_ force: Bool);
    func showAlert(message: String, button title: String, destructive: Bool, actionSheeet: Bool, handler: @escaping (Any) -> Void);
    func insert(tableView rows: [IndexPath]);
    func delete(tableView rows: [IndexPath]);
    func update(tableView rows: [IndexPath]);
}


protocol TodoListViewOutput: AnyObject {
    func viewDidAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func dataSource(numberOfRowsInSection section: Int) -> Int;
    func dataSource(objectAt index: Int) -> Todo?;
    func edit(todo: Todo?);
    func delete(todo: Todo?, force: Bool);
    func popup(info: TodoPopupInfo?);
    func search(text: String?);
    func complete(todo: Todo?, completed: Bool);
}


class TodoListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!;
    @IBOutlet var totalLabel: UILabel!;
    
    private var presenter: TodoListViewOutput!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.presenter = TodoListConfigurator.configure(view: self);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.presenter.viewDidAppear(animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.presenter.viewWillDisappear(animated);
    }
    
    @IBAction func longpressClick(_ sender: UILongPressGestureRecognizer) {
        let pt = sender.location(in: self.tableView);
        guard self.presentedViewController == nil,
              let index = self.tableView.indexPathForRow(at: pt),
              let cell = self.tableView.cellForRow(at: index) as? TodoListTableViewCell
        else {
            return;
        }
        let popup = TodoPopupInfo(todo: cell.todo, offset: self.tableView.offsetForCell(cell));
        self.presenter.popup(info: popup);
    }
    
    @IBAction func newClick(_ sender: Any) {
        self.presenter.edit(todo: nil);
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let controller as TodoListPopupViewController:
            controller.popupInfo = sender as? TodoPopupInfo;
        case let controller as TodoEditViewController:
            controller.todo = sender as? Todo;
        default:
            return;
        }
    }
    
    @IBAction func todoListUnwide(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func editUnwide(_ segue: UIStoryboardSegue, sender: Any?) {
        OperationQueue.main.addOperation {
            self.presenter.edit(todo: sender as? Todo);
        }
    }
    
    @IBAction func deleteUnwide(_ segue: UIStoryboardSegue, sender: Any?) {
        OperationQueue.main.addOperation {
            self.presenter.delete(todo: sender as? Todo, force: false);
        }
    }
    
    @IBAction func shareUnwide(_ segue: UIStoryboardSegue, sender: Any?) {
        print(#function);
    }
    
    @IBAction func searchClick(_ sender: Any?) {
        print(#function);
    }
    
    @IBAction func dictationClick(_ sender: Any?) {
        print(#function);
    }
    
}


extension TodoListViewController: TodoListViewInput {
    
    func updateTableView() {
        self.tableView.reloadData();
    }
    
    func update(total: String) {
        self.totalLabel.text = total;
    }
    
    func endEditing(_ force: Bool) {
        self.view.endEditing(force);
    }
    
    func insert(tableView rows: [IndexPath]) {
        self.tableView.insertRows(at: rows, with: .automatic);
        guard let first = rows.min() else {
            return;
        }
        self.tableView.scrollToRow(at: first, at: .middle, animated: true);
    }
    
    func delete(tableView rows: [IndexPath]) {
        self.tableView.deleteRows(at: rows, with: .automatic);
    }
    
    func update(tableView rows: [IndexPath]) {
        self.tableView.reloadRows(at: rows, with: .automatic);
    }
    
}


extension TodoListViewController: NavigationProtocol {
    
    var hideNavigationBar: Bool {
        true;
    }
    
}


extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.dataSource(numberOfRowsInSection: section);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier) as! TodoListTableViewCell;
        cell.todo = self.presenter.dataSource(objectAt: indexPath.row);
        return cell;
    }
    
}


extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = self.presenter.dataSource(objectAt: indexPath.row);
        self.presenter.edit(todo: todo);
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let block: (UIContextualAction, UIView, @escaping (Bool) -> Void) -> Void = { action, view, completed in
            let todo = self.presenter.dataSource(objectAt: indexPath.row);
            self.presenter.delete(todo: todo, force: true);
            completed(true);
        }
        let delete = UIContextualAction(style: .destructive, title: String(localizedString: "delete"), handler: block);
        delete.image = UIImage(systemName: "trash");
        return UISwipeActionsConfiguration(actions: [delete]);
    }
    
}


extension TodoListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.presenter.search(text: textField.text);
    }
    
}


extension TodoListViewController: TodoTableViewCellDelegate {
    
    func todoTableView(cell: UITableViewCell, completed: Bool) {
        guard let index = self.tableView.indexPath(for: cell),
              let todo = self.presenter.dataSource(objectAt: index.row)
        else {
            return;
        }
        self.presenter.complete(todo: todo, completed: completed);
    }
    
}
