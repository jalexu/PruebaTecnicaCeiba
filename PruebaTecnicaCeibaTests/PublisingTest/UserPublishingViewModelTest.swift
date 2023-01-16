//
//  UserPublishingViewModelTest.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import XCTest
import Resolver
@testable import PruebaTecnicaCeiba

class UserPublishingViewModelTest: XCTestCase {
    private var userPublishingInteractorStub: UserPublishingInteractorStub!
    private var sut: UserPublishingViewModel!
    
    struct TestConstant {
        static let user = Constants.PreviewsMocks.user
        static let xctFail = "Delay interrupted"
    }
    
    override func setUp() {
        super.setUp()
        Resolver.registerMockServices()
        userPublishingInteractorStub = UserPublishingInteractorStub()
        sut = UserPublishingViewModel(
            user: TestConstant.user,
            userPublishingInteractor: userPublishingInteractorStub)
    }
    
    override func tearDown() {
        userPublishingInteractorStub = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetUserPublishing_WhenReturnSuccess_ThenlistUserPublishigChanges() {
        //Give
        let expectation = XCTestExpectation(description: "Get user pusblishings from service")
        
        userPublishingInteractorStub.responseHandler = .success{ _ in
            Constants.PreviewsMocks.userPusblishings
        }
        
        //when
        sut.getUserPublishing()
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.state.listUserPublishig.isEmpty)
        } else {
            XCTFail(TestConstant.xctFail)
        }
    }
    
    func testGetUserPublishing_WhenReturnFailure_ThenListUserPublishigIsEmpty() {
        //Give
        let expectation = XCTestExpectation(description: "Hidden loading and Show alert error")
        
        userPublishingInteractorStub.responseHandler = .failure { _ in
            CostumErrors.ApiRequest.serverError
        }
        
        //when
        sut.getUserPublishing()
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.loading)
            XCTAssertTrue(sut.state.listUserPublishig.isEmpty)
            XCTAssertTrue(sut.state.alert)
        } else {
            XCTFail(TestConstant.xctFail)
        }
    }
    
    func testTryAgain_whenUserHaveInternetConnection_ThenGetPublishing() {
        //Give
        let expectation = XCTestExpectation(description: "Get user pusblishings when retry connection")
        
        userPublishingInteractorStub.responseHandler = .success{ _ in
            Constants.PreviewsMocks.userPusblishings
        }
        
        //when
        sut.tryAgain()
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.state.listUserPublishig.isEmpty)
            XCTAssertFalse(sut.state.showConnectionError)
        } else {
            XCTFail(TestConstant.xctFail)
        }
    }
    
    func testShowError_whenServicesHasError_ThenShowAlert() {
        //Give
        let expectation = XCTestExpectation(description: "Show alert Error")
        let errorTemp = NSError(domain:"Error text", code: 500, userInfo:nil)
        
        //when
        sut.showError(error: errorTemp)
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.alert)
            XCTAssertNotNil(sut.state.alertMessageError)
        } else {
            XCTFail(TestConstant.xctFail)
        }
    }
    
    func testShowLostConnectionError_whenServicesHasConnectionError_ThenRetryWiew() {
        //Give
        let expectation = XCTestExpectation(description: "Show retry view")
        
        //when
        sut.showLostConnectionError()
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.showConnectionError)
        } else {
            XCTFail(TestConstant.xctFail)
        }
    }
    
    func testHideLostConnectionError_whenServicesHasConnectionError_ThenHideRetryWiew() {
        //Give
        let expectation = XCTestExpectation(description: "Hide retry view")
        
        //when
        sut.hideLostConnectionError()
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.state.showConnectionError)
        } else {
            XCTFail(TestConstant.xctFail)
        }
    }
}
