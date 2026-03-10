//
//  UIView+Utils.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import UIKit;


extension UIView {
    
    func subview(at point: CGPoint, checkUserInteraction: Bool = false) -> UIView? {
        let view = self.subviews.first(where: {
            guard !checkUserInteraction || $0.isUserInteractionEnabled else {
                return false;
            }
            let point = $0.convert(point, from: self);
            return $0.point(inside: point, with: nil);
        } );
        return view;
    }
    
}
