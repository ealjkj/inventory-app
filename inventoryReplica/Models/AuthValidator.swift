//
//  AuthValidator.swift
//  inventoryReplica
//
//  Created by intekglobal02 on 9/15/23.
//

import Foundation

struct Validation {
    let isValid: Bool
    let message: String
}


struct Validator {
    let successfullValidation = Validation(isValid: true, message: "")
    
    func validateUsername(_ username: String) -> Validation {
        
        if(username.contains(" ")) {
            return Validation(isValid: false, message: "Username cannot contain whitespaces")
        }
        
        return successfullValidation
    }
    
    func validateEmail(_ email: String) -> Validation {
        
        if(!email.contains("@")) {
            return Validation(isValid: false, message: "Invalid email")
        }
        
        return successfullValidation
        
    }
    
    func validatePassword(_ password: String) -> Validation {
        
        if(password.count <= 8) {
            return Validation(isValid: false, message: "Password must contain at least 8 characters")
        }
        
        return successfullValidation
        
    }
    
    func validateSignUp(_ username: String, email: String, password: String, confirmPassword: String) -> Validation {
        
        
        let usernameValidation = validateUsername(username)
        if(!usernameValidation.isValid) {
            return usernameValidation
        }
        
        let passwordValidation = validatePassword(password)
        if(!passwordValidation.isValid) {
            return usernameValidation
        }
        
        let emailValidation = validateEmail(email)
        if(!passwordValidation.isValid) {
            return usernameValidation
        }
        if(password != confirmPassword) {
            return Validation(isValid: false, message: "Passwords must match")
        }
        
        return successfullValidation
    }
    
}
