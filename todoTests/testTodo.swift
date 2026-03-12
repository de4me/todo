//
//  testTodo.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;
import CoreData;

final class testTodo: XCTestCase {
    
    var objectId: NSManagedObjectID!;
    var todo: Todo!;
    var title: String!;
    var subtitile: String!;
    var createdDate: Date!;
    var completedDate: Date!;
    var data: Data!;
    var completed: Bool!;
    var id: Int!;

    override func setUpWithError() throws {
        self.objectId = NSManagedObjectID();
        self.title = "Title";
        self.subtitile = "Subtitle";
        self.createdDate = Date.distantPast;
        self.completedDate = Date.distantFuture;
        self.todo = Todo(id: self.objectId, title: self.title, subtitle: self.subtitile, createdDate: self.createdDate, completedDate: self.completedDate);
        self.completed = true;
        self.id = 1;
        self.data = "{ \"id\": \(self.id!), \"todo\": \"\(self.subtitile!)\", \"completed\": \(self.completed!) }".data(using: .utf8);
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() throws {
        XCTAssertEqual(todo.id, self.objectId);
        XCTAssertEqual(todo.title, self.title);
        XCTAssertEqual(todo.subtitle, self.subtitile);
        XCTAssertEqual(todo.createdDate, self.createdDate);
        XCTAssertEqual(todo.completedDate, self.completedDate);
    }
    
    func testCompleted() throws {
        XCTAssertTrue(todo.isCompleted);
        todo.completedDate = nil;
        XCTAssertFalse(todo.isCompleted);
    }
    
    func testObjectId() throws {
        XCTAssertEqual(todo.objectId(), self.objectId);
    }
    
    @MainActor
    func testDecode() throws {
        let decoder = JSONDecoder();
        let result = try decoder.decode(Todo.self, from: self.data!);
        XCTAssertEqual(result.title, "#\(self.id!)");
        XCTAssertEqual(result.subtitle, self.subtitile);
        XCTAssertEqual(result.isCompleted, self.completed);
    }

}
