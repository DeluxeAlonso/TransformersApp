//
//  TransformersAppUITests.swift
//  TransformersAppUITests
//
//  Created by Alonso on 12/3/20.
//

import XCTest

class TransformersAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddBarButtonItemExists() {
        let app = XCUIApplication()
        app.activate()

        let rightNavBarButton = XCUIApplication().navigationBars.buttons["addBarButtonItem"]
        XCTAssert(rightNavBarButton.exists)
    }

    func testAddScreenOpening() {
        let app = XCUIApplication()
        app.activate()

        let rightNavBarButton = XCUIApplication().navigationBars.buttons["addBarButtonItem"]
        rightNavBarButton.tap()

        let cells = app.tables.cells

        XCTAssert(cells.count > 0)
    }

}
