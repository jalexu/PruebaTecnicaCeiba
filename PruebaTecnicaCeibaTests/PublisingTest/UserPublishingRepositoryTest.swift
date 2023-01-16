//
//  UserPublishingRepositoryTest.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import XCTest
import Combine
@testable import PruebaTecnicaCeiba

final class UserPublishingRepositoryTest: XCTestCase {
    private var cancellable: AnyCancellable?
    private var networkService: NetworkServiceType!
    private var sut: UserPublishingRepositoryType!

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = NetworkServiceStub()
        sut = UserPublishingRepository(networkService: networkService)
    }

    override func tearDownWithError() throws {
        NetworkServiceStub.error = nil
        NetworkServiceStub.response = nil
        networkService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func testGetUser_WhenCallGetUserPublishing_ThenGetSuccessResponseWithData() {
        //Give
        let expectation = self.expectation(description: "Get users Response Expectation")
        NetworkServiceStub.response = Constants.PreviewsMocks.userPusblishings as AnyObject

        //When
        cancellable = sut.getUserPublishing(idUser: 2)
            .sink( receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
            }, receiveValue: { userPusblishings in
                XCTAssertEqual(userPusblishings.count, 2)
                expectation.fulfill()
            })
        //Then
        wait(for: [expectation], timeout: 0.5)
        cancellable?.cancel()
    }
    
    func testGetUser_WhenCallGetUserPublishing_ThenGetResponseFailure() {
        //Give
        let expectation = self.expectation(description: "Get users failure")
        NetworkServiceStub.response = Constants.PreviewsMocks.userPusblishings as AnyObject
        NetworkServiceStub.error = CostumErrors.ApiRequest.serverError

        //When
        cancellable = sut.getUserPublishing(idUser: 2)
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

