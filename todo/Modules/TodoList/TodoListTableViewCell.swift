//
//  TodoTableViewCell.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


@objc protocol TodoTableViewCellDelegate {
    func todoTableView(cell: UITableViewCell, completed: Bool);
}


class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!;
    @IBOutlet var subtitleLabel: UILabel!;
    @IBOutlet var dateLabel: UILabel!;
    @IBOutlet var completedButton: UIButton!;
    @IBOutlet var highlightedBackgroundView: UIView!;
    
    @IBOutlet weak var delegate: TodoTableViewCellDelegate?;
    
    static var identifier = "todo";
    
    var todo: Todo? {
        didSet {
            self.update(todo: self.todo);
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.highlightedBackgroundView.isHidden = !highlighted;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    @IBAction func completedClick(_ sender: UIButton) {
        self.delegate?.todoTableView(cell: self, completed: !sender.isSelected);
    }
    
    private func update(todo: Todo?) {
        guard let todo else {
            return;
        }
        self.titleLabel.isHighlighted = todo.isCompleted;
        self.titleLabel.text = todo.title;
        self.subtitleLabel.isHighlighted = todo.isCompleted;
        self.subtitleLabel.text = todo.subtitle;
        self.completedButton.isSelected = todo.isCompleted;
        self.dateLabel.text = todo.localizedCreatedDate
    }

}
