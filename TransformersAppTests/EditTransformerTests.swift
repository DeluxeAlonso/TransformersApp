//
//  EditTransformerTests.swift
//  TransformersAppTests
//
//  Created by Alonso on 12/7/20.
//

import XCTest
@testable import TransformersApp

class EditTransformerTests: XCTestCase {

    var mockInteractor: MockTransformerDetailInteractor!
    var viewModelToTest: EditTransformerViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockTransformerDetailInteractor()
        let mockTransformer = Transformer.with()
        viewModelToTest = EditTransformerViewModel(mockTransformer,
                                                   interactor: mockInteractor,
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
        XCTAssertTrue(shouldAllowEditing)
    }

    func testShouldStartOnEditMode() {
        //Act
        let shouldStartOnEditMode = viewModelToTest.shouldStartOnEditMode()
        //Assert
        XCTAssertFalse(shouldStartOnEditMode)
    }

    func testEditTransformerSuccess() {
        ///Arrange
        let transformerToTest = Transformer.with(id: "2")
        mockInteractor.updateTransformerResult = Result.success(transformerToTest)
        let expectation = XCTestExpectation(description: "Update transformer success")
        //Act
        viewModelToTest.savedTransformer.bind { transformer in
            XCTAssertEqual(transformer?.id, transformerToTest.id)
            expectation.fulfill()
        }
        viewModelToTest.saveTransformer()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testEditTransformerError() {
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
