//
//  testTodoListPopupModule.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;


final class testTodoListPopupModule: XCTestCase {
    
    var view: TodoListPopupViewDump!;
    var presenter: (TodoListPopupViewOutput & TodoListPopupPresenterProtocol)!;
    var todo: Todo!;
    var popupInfo: TodoPopupInfo!;
    var offset: CGFloat!;

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.view = TodoListPopupViewDump();
        self.presenter = TodoListPopupConfigurator.configure(view: self.view!);
        self.todo = Todo();
        self.offset = .pi;
        self.popupInfo = TodoPopupInfo(todo: self.todo, offset: self.offset);
        self.view.popupInfo = self.popupInfo;
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConfigure() throws {
        XCTAssertNotNil(self.presenter.view);
        XCTAssertNotNil(self.presenter.interactor);
        XCTAssertNotNil(self.presenter.router);
        XCTAssertNotNil(self.presenter.interactor?.presenter);
        XCTAssertNotNil(self.presenter.router?.presenter);
    }
    
    func testRouteClose() throws {
        self.presenter.close();
        XCTAssertEqual(self.view.route, TodoListPopupRouter.Name.close);
    }
    
    func testRouteEdit() throws {
        self.presenter.edit();
        XCTAssertEqual(self.view.route, TodoListPopupRouter.Name.edit);
    }
    
    func testRouteShare() throws {
        self.presenter.share();
        XCTAssertEqual(self.view.route, TodoListPopupRouter.Name.share);
    }
    
    func testRouteDelete() throws {
        self.presenter.delete();
        XCTAssertEqual(self.view.route, TodoListPopupRouter.Name.delete);
    }
    
    func testGetValuePopupInfo() throws {
        let popinfo = self.presenter.interactor?.presenter?.getValuePopupInfo();
        XCTAssertNotNil(popinfo);
    }
    
    func testAppearance() throws {
        self.presenter.viewDidLoad();
        XCTAssertEqual(self.view.popupViewAlpha, 0);
        self.presenter.viewWillAppear(true);
        XCTAssertNotNil(self.view.todo);
        XCTAssertEqual(self.view.topLayoutConstraint, self.offset);
    }

}
