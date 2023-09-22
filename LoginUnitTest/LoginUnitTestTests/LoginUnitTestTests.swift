//
//  LoginUnitTestTests.swift
//  LoginUnitTestTests
//
//  Created by Anusha Kg on 22/09/23.
//

import XCTest
@testable import LoginUnitTest

final class LoginUnitTestTests: XCTestCase {
    
    let testview =  TokenViewModel()

    override func setUpWithError() throws {
        }

    override func tearDownWithError() throws {
       }

    func testTokenViewModelFetchToken() {
            // Test a successful login
            testview.fetchToken(username: "atistagetest", password: "Password1")
            
            
            let expectation = XCTestExpectation(description: "login successful")
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                XCTAssertTrue(self.testview.isLoggedIn)
                XCTAssertNil(self.testview.loginError)
                XCTAssertNotNil(self.testview.tokenData)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 10.0)
        }

    func testTokenViewModelFetchTokenWithInvalidCredentials() {
           // Test a login with invalid credentials
        testview.fetchToken(username: "hsgfsa", password: "anusha12")
        
           let expectation = XCTestExpectation(description: "login failed")
           
           DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
               XCTAssertFalse(self.testview.isLoggedIn)
               XCTAssertNotNil(self.testview.loginError)
               XCTAssertNil(self.testview.tokenData)
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 10.0)
       }

}
