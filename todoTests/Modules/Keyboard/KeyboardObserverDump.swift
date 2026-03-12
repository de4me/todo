//
//  KeyboardObserverDump.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import CoreGraphics;
@testable import todo;


class KeyboardObserverDump: KeyboardObserverInput {
    
    var output: KeyboardObserverOutput?;
    var isRegistered: Bool?;
    let size: CGSize;
    
    init(output: KeyboardObserverOutput?, size: CGSize) {
        self.output = output;
        self.size = size;
    }
    
    func registerObserver() {
        self.isRegistered = true;
        self.output?.keyboardFrameChanged(frame: .init(origin: .zero, size: size));
    }
    
    func unregisterObserver() {
        self.isRegistered = false;
    }
    
}
