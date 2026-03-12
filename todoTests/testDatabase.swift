//
//  testDatabase.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;

import CoreData;


final class testDatabase: XCTestCase {
    
    var todo: Todo!;
    var title: String!;
    var subtitile: String!;
    var createdDate: Date!;
    var completedDate: Date!;
    var container: NSPersistentCloudKitContainer!;

    override func setUpWithError() throws {
        self.title = "Title";
        self.subtitile = "Subtitle";
        self.createdDate = Date.distantPast;
        self.completedDate = Date.distantFuture;
        self.todo = Todo(title: self.title, subtitle: self.subtitile, createdDate: self.createdDate, completedDate: self.completedDate)
        self.container = memoryPersistentContainer();
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAssign() throws {
        let context = self.container.newBackgroundContext();
        let dbtodo = DBTodo(context: context);
        dbtodo.assign(todo: self.todo);
        XCTAssertEqual(dbtodo.title, self.title);
        XCTAssertEqual(dbtodo.subtitle, self.subtitile);
        XCTAssertEqual(dbtodo.createdDate, self.createdDate);
        XCTAssertEqual(dbtodo.completedDate, self.completedDate);
    }
    
    
    func testTodoInit() throws {
        let context = self.container.newBackgroundContext();
        let dbtodo = DBTodo(context: context);
        dbtodo.assign(todo: self.todo);
        let todo = Todo(db: dbtodo);
        XCTAssertEqual(todo.id, dbtodo.objectID);
        XCTAssertEqual(todo.title, dbtodo.title);
        XCTAssertEqual(todo.subtitle, dbtodo.subtitle);
        XCTAssertEqual(todo.createdDate, dbtodo.createdDate);
        XCTAssertEqual(todo.completedDate, dbtodo.completedDate);
    }


}
