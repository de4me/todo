//
//  UiTableView+Utils.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


extension UITableView {
    
    func offsetForCell(_ cell: UITableViewCell) -> CGFloat {
        let rect = self.convert(cell.frame, to: nil);
        return rect.minY;
    }
    
}
