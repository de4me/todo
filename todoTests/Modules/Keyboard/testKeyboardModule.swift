//
//  testKeyboardModule.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;





final class testKeyboardModule: XCTestCase {
    
    var view: KeyboardViewDump!;
    var configure: KeyboardPresenterProtocol!;
    var presenter: KeyboardPresenter!;
    var interactor: KeyboardInteractor!;
    var keyboardObserver: KeyboardObserverDump!;
    var size: CGSize!;

    @MainActor
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.size = CGSize(width: 375, height: 812);
        self.view = KeyboardViewDump();
        self.configure = KeyboardConfigurator.configure(view: self.view);
        self.presenter = KeyboardPresenter(view: self.view, interactor: nil);
        self.interactor = KeyboardInteractor(presenter: self.presenter, keyboardObserver: nil);
        self.keyboardObserver = KeyboardObserverDump(output: self.interactor, size: self.size);
        self.interactor.keyboardObserver = self.keyboardObserver;
        self.presenter.interactor = self.interactor;
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConfigure() throws {
        XCTAssertNotNil(self.configure.interactor);
        XCTAssertNotNil(self.configure.view);
        XCTAssertNotNil(self.configure.interactor?.presenter);
        XCTAssertNotNil(self.configure.interactor?.keyboardObserver);
        XCTAssertNotNil(self.configure.interactor?.keyboardObserver?.output);
    }
    
    func testModule() throws {
        XCTAssertNotNil(self.presenter.interactor);
        XCTAssertNotNil(self.presenter.view);
        XCTAssertNotNil(self.presenter.interactor?.presenter);
        XCTAssertNotNil(self.presenter.interactor?.keyboardObserver);
        XCTAssertNotNil(self.presenter.interactor?.keyboardObserver?.output);
    }
    
    func testViewDidAppear() throws {
        self.presenter.viewDidAppear(true);
        XCTAssert(self.keyboardObserver.isRegistered == true);
        XCTAssertTrue(self.view.isUpdateConstraints);
        XCTAssertEqual(self.view.keyboardLayoutConstraint, self.size.height + self.view.getValueKeyboardSpace());
        
    }
    
    func testViewWillDisappear() throws {
        self.presenter.viewWillDisappear(true);
        XCTAssert(self.keyboardObserver.isRegistered == false);
    }
    
    func testUpdateKeyboardLayout() throws {
        self.presenter.update(keyboardLayoutConstraint: self.size.height);
        XCTAssertEqual(self.view.keyboardLayoutConstraint, self.size.height + self.view.getValueKeyboardSpace());
    }

}
