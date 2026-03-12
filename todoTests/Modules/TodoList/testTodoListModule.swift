//
//  testTodoListModule.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;


final class testTodoListModule: XCTestCase {
    
    var view: TodoListViewDump!;
    var presenter: (TodoListPresenterProtocol & TodoListViewOutput & TodoListInteractorOutput)!;
    var todo: Todo!;
    var title: String!;
    var subtitile: String!;
    var createdDate: Date!;
    var completedDate: Date!;
    var popupInfo: TodoPopupInfo!;
    var error: Error!;

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.view = TodoListViewDump();
        self.presenter = TodoListConfigurator.configure(view: view!);
        self.title = "Title";
        self.subtitile = "Subtitle";
        self.createdDate = Date.distantPast;
        self.completedDate = Date.distantFuture;
        self.todo = Todo(id: nil, title: self.title, subtitle: self.subtitile, createdDate: self.createdDate, completedDate: self.completedDate);
        self.popupInfo = TodoPopupInfo(todo: self.todo, offset: .pi);
        self.error = POSIXError(.E2BIG);
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConfigure() throws {
        XCTAssertNotNil(self.presenter.view);
        XCTAssertNotNil(self.presenter.interactor);
        XCTAssertNotNil(self.presenter.router);
        XCTAssertNotNil(self.presenter.interactor?.datasource);
        XCTAssertNotNil(self.presenter.interactor?.presenter);
        XCTAssertNotNil(self.presenter.router?.presenter);
        XCTAssertNotNil(self.presenter.interactor?.datasource?.output);
    }
    
    func testRouteEdit() throws {
        self.presenter.edit(todo: self.todo);
        XCTAssertEqual(self.view.route, TodoListRouter.Name.edit);
    }
    
    func testRoutePopup() throws {
        self.presenter.popup(info: self.popupInfo);
        XCTAssertEqual(self.view.route, TodoListRouter.Name.popup);
    }
    
    func testUpdateTotal() throws {
        self.presenter.update(total: 1);
        XCTAssertNotNil(self.view.total);
    }
    
    func testEndediting() throws {
        self.presenter.endEditing(true);
        XCTAssertTrue(self.view.valueEndEditing);
    }
    
    func testUpdateTableView() throws {
        self.presenter.updateTableView();
        XCTAssertTrue(self.view.valueUpdateTableView);
    }
    
    func testPerformSegue() throws {
        self.presenter.router?.edit(todo: self.todo);
        XCTAssertEqual(self.view.route, TodoListRouter.Name.edit);
    }
    
    func testDidSaveWithError() throws {
        self.presenter.showError(self.error);
        XCTAssertNotNil(self.view.error);
    }

}
