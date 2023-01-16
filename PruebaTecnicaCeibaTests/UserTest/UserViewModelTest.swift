//
//  UserViewModelTest.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import XCTest
import Resolver
@testable import PruebaTecnicaCeiba

final class UserViewModelTest: XCTestCase {
    private var userInteractor: UserInteractorStub!
    private var coreDataInteractor: CoreDataInteractorStub!
    private var sut: UserViewModel!
    
    struct TestConstant {
        static let xctFail = "Delay interrupted"
    }

    override func setUpWithError() throws {
        Resolver.registerMockServices()
        try super.setUpWithError()
        userInteractor = UserInteractorStub()
        coreDataInteractor = CoreDataInteractorStub(users: [])
        sut = .init(getUsersInteractor: userInteractor, coreDataInteractor: coreDataInteractor)
    }

    override func tearDownWithError() throws {
        userInteractor = nil
        coreDataInteractor = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testOnAppear_WhenReturnSuccess_ThenUserChanges() {
        //Give
        let expectation = XCTestExpectation(description: "Get user from service")
        
        userInteractor.responseHandler = .success { _ in
            Constants.PreviewsMocks.users
        }
        
        coreDataInteractor.responseHandler = .success{}
        
        //when
        sut.getUserService()
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.state.users.isEmpty)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testOnAppear_WhenReturnError_ThenUserIsEmpty() {
        //Give
        let expectation = XCTestExpectation(description: "Get user from service error")
        
        userInteractor.responseHandler = .failure { _ in
            CostumErrors.ApiRequest.pageNotFound
        }
        
        coreDataInteractor.responseHandler = .failure {
            CostumErrors.ApiRequest.errorCoreData
        }
        
        //when
        sut.getUserService()
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.users.isEmpty)
        } else {
            XCTFail("Delay interrupted")
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
    
    func testTryAgain_whenUserHaveInternetConnection_ThenGetUsers() {
        //Give
        let expectation = XCTestExpectation(description: "Get users when retry connection")
        
        userInteractor.responseHandler = .success { _ in
            Constants.PreviewsMocks.users
        }
        
        coreDataInteractor.responseHandler = .success { }
        
        //when
        sut.tryAgain()
        
        //Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.state.users.isEmpty)
            XCTAssertFalse(sut.state.showConnectionError)
        } else {
            XCTFail(TestConstant.xctFail)
        }
    }
    
    func testShowLostConnectionError_whenServicesHasConnectionError_ThenShowRetryWiew() {
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
