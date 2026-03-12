//
//  testKeyboardModule.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;


class KeyboardViewDump: KeyboardViewInput {
    
    func update(keyboardLayoutConstraint: CGFloat) {
        
    }
    
    func updateConstraints() {
        
    }
    
    func getValueBounds() -> CGRect {
        .zero;
    }
    
    func getValueKeyboardSpace() -> CGFloat {
        0;
    }

}


final class testKeyboardModule: XCTestCase {
    
    var view: KeyboardViewDump!;
    var presenter: KeyboardPresenterProtocol!;

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.view = KeyboardViewDump();
        self.presenter = KeyboardConfigurator.configure(view: view!);
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConfigure() throws {
        XCTAssertNotNil(self.presenter.interactor);
        XCTAssertNotNil(self.presenter.view);
        XCTAssertNotNil(self.presenter.interactor?.presenter);
        XCTAssertNotNil(self.presenter.interactor?.keyboardObserver);
        XCTAssertNotNil(self.presenter.interactor?.keyboardObserver?.output);
    }

}
