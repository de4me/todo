//
//  String+Utils.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;


extension String {
    
    static func isEmpty(string: String?) -> Bool {
        return string?.trimmed().isEmpty ?? true;
    }
    
    init(localized: String) {
        self = NSLocalizedString(localized, comment: localized);
    }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines);
    }
    
    func nilIfEmpty() -> String? {
        self.isEmpty ? nil : self;
    }
    
}
