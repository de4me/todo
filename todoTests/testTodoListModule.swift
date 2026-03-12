//
//  testTodoListModule.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;

class TodoListViewDump: TodoListViewInput {
    
    var route: String?;
    var total: String?;
    var error: Error?;
    var valueEndEditing = false;
    var valueUpdateTableView = false;
    var setErrorExpectation: XCTestExpectation = .init(description: "Set error");
    
    func performSegue(withIdentifier indentifier: String, sender: Any?) {
        self.route = indentifier;
    }
    
    func updateTableView() {
        self.valueUpdateTableView = true;
    }
    
    func update(total: String) {
        self.total = total;
    }
    
    func showError(_ error: any Error) {
        self.error = error;
        self.setErrorExpectation.fulfill();
    }
    
    func endEditing(_ force: Bool) {
        self.valueEndEditing = true;
    }
    
}


final class testTodoListModule: XCTestCase {
    
    var view: TodoListViewDump!;
    var presenter: (TodoListPresenterProtocol & TodoListViewOutput)!;
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
        self.presenter.performSegue(withIdentifier: TodoListRouter.Name.edit, sender: nil);
        XCTAssertEqual(self.view.route, TodoListRouter.Name.edit);
    }
    
    func testDidSaveWithError() throws {
        self.presenter.didSaveWithError(self.error);
        wait(for: [self.view.setErrorExpectation], timeout: 1.0);
        XCTAssertNotNil(self.view.error);
    }

}
