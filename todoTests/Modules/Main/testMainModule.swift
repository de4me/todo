//
//  testMainModule.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import XCTest;
@testable import todo;


final class testMainModule: XCTestCase {
    
    var view: MainViewDump?;
    var presenter: MainPresenterProtocol?;

    @MainActor
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.view = MainViewDump();
        self.presenter = MainConfigurator.configure(view: self.view!);
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConfigure() throws {
        XCTAssertNotNil(self.view?.delegate);
        XCTAssertNotNil(self.presenter?.view);
        XCTAssertNotNil(self.presenter?.interactor);
        XCTAssertNotNil(self.presenter?.interactor?.presenter);
    }

}
