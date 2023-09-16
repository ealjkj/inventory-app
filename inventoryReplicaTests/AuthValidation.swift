//
//  AuthValidation.swift
//  inventoryReplicaTests
//
//  Created by intekglobal02 on 9/15/23.
//

import XCTest
@testable import inventoryReplica


final class AuthValidation: XCTestCase {
    
    let validator = Validator()

    func testValidateUsername_shouldFail_ifThereAreWhiteSpaces()  {
        let validation = validator.validateUsername(" this should fail")
        XCTAssertFalse(validation.isValid)
    }
    
    func testValidateUsername_shouldSucceed_ifThereAreNotWhiteSpaces()  {
        let validation = validator.validateUsername("trimmedUsername")
        XCTAssertTrue(validation.isValid)
    }
    
    func testValidatePassword_shouldFail_ifItIsTooshort()  {
        let validation = validator.validatePassword("short")
        XCTAssertFalse(validation.isValid)
    }
    
    func testValidatePassword_shouldSucceed_ifItIsValid()  {
        let validation = validator.validatePassword("SecurePassword3#")
        XCTAssertTrue(validation.isValid)
    }
    
    func testValidateEmail_shouldFail_ifItIsNotValid()  {
        let validation1 = validator.validateEmail("notEmail")
        let validation2 = validator.validateEmail("@")
        let validation3 = validator.validateEmail("as@a")
        XCTAssertFalse(validation1.isValid)
        XCTAssertFalse(validation2.isValid)
        XCTAssertFalse(validation3.isValid)
    }
    
    func testValidateEmail_shouldSucceed_ifItIsValid()  {
        let validation = validator.validateEmail("a@a.com")
        XCTAssertTrue(validation.isValid)
    }

}
