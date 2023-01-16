//
//  UserInteractorTest.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import XCTest
import Combine
@testable import PruebaTecnicaCeiba

final class UserInteractorTest: XCTestCase {
    private var cancellable: AnyCancellable?
    private var userRepository: UserRepositoryType!
    private var sut: UserInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userRepository = UserRepositoryStub()
        sut = UserInteractor(userRepository: userRepository)
    }

    override func tearDownWithError() throws {
        userRepository = nil
        sut = nil
        UserRepositoryStub.error = nil
        UserRepositoryStub.response = nil
        try super.tearDownWithError()
    }
    
    func testExecute_WhenCallGetUser_ThenGetSuccessResponseWithData() {
        //Give
        let expectation = self.expectation(description: "Get users Response Expectation")
        UserRepositoryStub.response = Constants.PreviewsMocks.users

        //When
        cancellable = sut.execute(params: nil)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
            }, receiveValue: { users in
                XCTAssertEqual(users.count, 2)
                expectation.fulfill()
            })

        //Then
        wait(for: [expectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func testExecute_WhenCallGetUser_ThenGetResponseFailure() {
        //Give
        let expectation = expectation(description: "Get users Response Failure")
        UserRepositoryStub.error = CostumErrors.ApiRequest.serverError

        //When
        cancellable = sut.execute(params: nil)
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
