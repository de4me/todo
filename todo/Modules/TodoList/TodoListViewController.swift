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
}


protocol TodoListViewOutput: AnyObject {
    func viewWillAppear(_ animated: Bool);
    func viewWillDisappear(_ animated: Bool);
    func dataSource(numberOfRowsInSection section: Int) -> Int;
    func dataSource(objectAt index: Int) -> Todo?;
    func edit(todo: Todo?);
    func delete(todo: Todo?);
    func popup(todo: Todo?);
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.presenter.viewWillAppear(animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.presenter.viewWillDisappear(animated);
    }
    
    @IBAction func longpressClick(_ sender: UILongPressGestureRecognizer) {
        //TODO: Popup todo
    }
    
    @IBAction func newClick(_ sender: Any) {
        self.presenter.edit(todo: nil);
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO: Popup
        //TODO: Edit
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
            self.presenter.delete(todo: sender as? Todo);
        }
    }
    
    @IBAction func shareUnwide(_ segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func searchClick(_ sender: Any?) {
        print(#function);
    }
    
    @IBAction func dictationClick(_ sender: Any?) {
        print(#function);
    }

    @IBAction func searchValueChanged(_ sender: Any?) {
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
