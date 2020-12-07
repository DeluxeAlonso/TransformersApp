//
//  TransformersTests.swift
//  TransformersAppTests
//
//  Created by Alonso on 12/7/20.
//

import XCTest
@testable import TransformersApp

class TransformersTests: XCTestCase {

    var mockInteractor: MockTransformersInteractor!
    var viewModelToTest: TransformersViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockTransformersInteractor()
        viewModelToTest = TransformersViewModel(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockInteractor = nil
        viewModelToTest = nil
    }

    func testGetTransformersPopulated() {
        //Arrange
        let transformersToTest = [Transformer.with(id: "1"), Transformer.with(id: "2")]
        mockInteractor.getTransformersResult = Result.success(transformersToTest)
        //Act
        viewModelToTest.getTransformers()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated)
    }

    func testGetReviewsPopulatedNumberOfCells() {
        //Arrange
        let transformersToTest = [Transformer.with(id: "1"), Transformer.with(id: "2")]
        mockInteractor.getTransformersResult = Result.success(transformersToTest)
        //Act
        viewModelToTest.getTransformers()
        //Assert
        XCTAssertEqual(viewModelToTest.transformerCells.count, transformersToTest.count)
    }

    func testGetTransformersEmpty() {
        //Arrange
        mockInteractor.getTransformersResult = Result.success([])
        //Act
        viewModelToTest.getTransformers()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }

    func testGetTransformersError() {
        //Arrange
        mockInteractor.getTransformersResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getTransformers()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

    func testDeleteTransformerSuccess() {
        //Arrange
        let transformersToTest = [Transformer.with(id: "1"), Transformer.with(id: "2")]
        mockInteractor.getTransformersResult = Result.success(transformersToTest)
        mockInteractor.deleteTransformerError = nil
        //Act
        viewModelToTest.getTransformers()
        viewModelToTest.removeTransformer(at: 0)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated)
    }

    func testDeleteTransformerSuccessNumberOfCells() {
        //Arrange
        let transformersToTest = [Transformer.with(id: "1"), Transformer.with(id: "2")]
        mockInteractor.getTransformersResult = Result.success(transformersToTest)
        mockInteractor.deleteTransformerError = nil
        //Act
        viewModelToTest.getTransformers()
        viewModelToTest.removeTransformer(at: 0)
        //Assert
        XCTAssertEqual(viewModelToTest.transformerCells.count, transformersToTest.count - 1)
    }

    func testDeleteTransformerError() {
        //Arrange
        let transformersToTest = [Transformer.with(id: "1"), Transformer.with(id: "2")]
        mockInteractor.getTransformersResult = Result.success(transformersToTest)
        mockInteractor.deleteTransformerError = APIError.badRequest
        let expectation = XCTestExpectation(description: "Delete success")
        //Act
        viewModelToTest.receivedErrorMessage.bind { errorMessage in
            XCTAssertNotNil(errorMessage)
            expectation.fulfill()
        }
        viewModelToTest.getTransformers()
        viewModelToTest.removeTransformer(at: 0)
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - War tests

}
