//
//  UserPublishingInteractorTest.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import XCTest
import Combine
@testable import PruebaTecnicaCeiba

final class UserPublishingInteractorTest: XCTestCase {
    
    private var cancellable: AnyCancellable?
    private var userPublishingRepository: UserPublishingRepositoryType!
    private var sut: UserPublishingInteractor!

    override func setUpWithError() throws {
        try super.setUpWithError()
        userPublishingRepository = UserPublishingRepositoryStub()
        sut = UserPublishingInteractor(userPublishingRepository: userPublishingRepository)
    }

    override func tearDownWithError() throws {
        UserPublishingRepositoryStub.response = nil
        UserPublishingRepositoryStub.error = nil
        userPublishingRepository = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testExecute_WhenCallGetUserPusblishings_ThenGetSuccessResponseWithData() {
        //Give
        let expectation = self.expectation(description: "Get users Response Expectation")
        UserPublishingRepositoryStub.response = Constants.PreviewsMocks.userPusblishings

        //When
        cancellable = sut.execute(params: 2)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
            }, receiveValue: { pusblishings in
                XCTAssertEqual(pusblishings.count, 2)
                expectation.fulfill()
            })

        //Then
        wait(for: [expectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func testExecute_WhenCallGetUserPusblishings_ThenGetResponseFailure() {
        //Give
        let expectation = expectation(description: "Get users Response Failure")
        UserPublishingRepositoryStub.error = CostumErrors.ApiRequest.serverError

        //When
        cancellable = sut.execute(params: 2)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTAssertNotNil(error)
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Delay interrupted")
            })

        //Then
        wait(for: [expectation], timeout: 1)
        cancellable?.cancel()
    }

}
