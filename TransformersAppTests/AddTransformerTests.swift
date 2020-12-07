//
//  AddTransformerTests.swift
//  TransformersAppTests
//
//  Created by Alonso on 12/7/20.
//

import XCTest
@testable import TransformersApp

class AddTransformerTests: XCTestCase {

    var mockInteractor: MockTransformerDetailInteractor!
    var viewModelToTest: AddTransformerViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockTransformerDetailInteractor()
        viewModelToTest = AddTransformerViewModel(interactor: mockInteractor,
                                                  factory: TransformerDetailFactory())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockInteractor = nil
        viewModelToTest = nil
    }

    func testShouldAllowEditing() {
        //Act
        let shouldAllowEditing = viewModelToTest.shouldAllowEditing()
        //Assert
        XCTAssertFalse(shouldAllowEditing)
    }

    func testShouldStartOnEditMode() {
        //Act
        let shouldStartOnEditMode = viewModelToTest.shouldStartOnEditMode()
        //Assert
        XCTAssertTrue(shouldStartOnEditMode)
    }

    func testAddTransformerError() {
        ///Arrange
        mockInteractor.updateTransformerResult = Result.failure(APIError.badRequest)
        let expectation = XCTestExpectation(description: "Update transformer success")
        //Act
        viewModelToTest.receivedErrorMessage.bind { errorMessage in
            XCTAssertNotNil(errorMessage)
            expectation.fulfill()
        }
        viewModelToTest.saveTransformer()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }

}
