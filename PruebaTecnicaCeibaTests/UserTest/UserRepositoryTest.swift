//
//  UserRepositoryTest.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import XCTest
import Combine
@testable import PruebaTecnicaCeiba

final class UserRepositoryTest: XCTestCase {
    private var cancellable: AnyCancellable?
    private var networkService: NetworkServiceType!
    private var sut: UserRepositoryType!

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = NetworkServiceStub()
        sut = UserRepository(networkService: networkService)
    }

    override func tearDownWithError() throws {
        NetworkServiceStub.error = nil
        NetworkServiceStub.response = nil
        networkService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func testGetUser_WhenCallGetUser_ThenGetSuccessResponseWithData() {
        //Give
        let expectation = self.expectation(description: "Get users Response Expectation")
        NetworkServiceStub.response = Constants.PreviewsMocks.users as AnyObject

        //When
        cancellable = sut.getUser()
            .sink( receiveCompletion: { completion in
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
    
    func testGetUser_WhenCallGetUser_ThenGetResponseFailure() {
        //Give
        let expectation = self.expectation(description: "Get users failure")
        NetworkServiceStub.response = Constants.PreviewsMocks.users as AnyObject
        NetworkServiceStub.error = CostumErrors.ApiRequest.serverError

        //When
        cancellable = sut.getUser()
            .sink( receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTAssertNotNil(error)
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Delay interrupted")
            })
        //Then
        wait(for: [expectation], timeout: 0.5)
        cancellable?.cancel()
    }
}
