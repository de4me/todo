//
//  testTodoEditModule.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;


class TodoEditViewDump: TodoEditViewInput {
    
    var route: String?;
    var todo: Todo?;
    var error: Error?;
    var updateTodo: Todo?;
    
    let editTitle = "Edit Title";
    let editSubtitle = "Edit Subtitle";
    
    func performSegue(withIdentifier indentifier: String, sender: Any?) {
        self.route = indentifier;
    }
    
    func updateTodo(todo: todo.Todo?) {
        self.updateTodo = todo;
    }
    
    func getValueEditResult() -> TodoEditResult {
        .init(title: self.editTitle, subtitle: self.editSubtitle);
    }
    
    func getValueTodo() -> todo.Todo? {
        self.todo;
    }
    
    func showError(_ error: any Error) {
        self.error = error;
    }
    
}


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
