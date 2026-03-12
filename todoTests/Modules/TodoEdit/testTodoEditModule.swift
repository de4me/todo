//
//  testTodoEditModule.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;


final class testTodoEditModule: XCTestCase {
    
    var view: TodoEditViewDump!;
    var presenter: (TodoEditViewOutput & TodoEditPresenterProtocol)!;
    var todo: Todo!;

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.view = TodoEditViewDump();
        self.presenter = TodoEditConfigurator.configure(view: self.view!);
        self.todo = Todo(id: nil, title: "Title", createdDate: Date.distantPast, completedDate: Date.distantFuture);
        self.view.todo = self.todo;
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
        XCTAssertEqual(self.view.route, TodoEditRouter.Name.close);
    }
    
    func testAppearence() throws {
        self.presenter.viewWillAppear(true);
        XCTAssertNotNil(self.view.updateTodo);
    }

}
