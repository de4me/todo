//
//  Preferences.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


protocol PreferencesProtocol {
    var updated: Bool { get set }
}


fileprivate enum PreferenceKey: String {
    case update;
}


@propertyWrapper
struct PreferenceWrapper<T> {
    
    fileprivate let key: PreferenceKey;
    let defaultValue: T;
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key.rawValue) as? T ?? self.defaultValue;
        }
        set {
            UserDefaults.standard.set(newValue, forKey: self.key.rawValue);
        }
    }
    
}


class Preferences: PreferencesProtocol {
    
    @PreferenceWrapper(key: .update, defaultValue: false) var updated: Bool;
    
}
