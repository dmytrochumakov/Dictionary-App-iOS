//
//  RegisterValidation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.09.2021.
//

import Foundation

protocol RegisterValidationProtocol {
    var isValid: Bool { get }
    var validationErrors: [RegisterValidationError] { get }
}

protocol RegisterValidationDataProviderProtocol {
    var nickname: String? { get set }
    var password: String? { get set }
    var confirmPassword: String? { get set }
}

final class RegisterValidation: NSObject, RegisterValidationProtocol {
    
    fileprivate let dataProvider: RegisterValidationDataProviderProtocol
    fileprivate let validationTypes: [RegisterValidationType]
    
    init(dataProvider: RegisterValidationDataProviderProtocol,
         validationTypes: [RegisterValidationType]) {
        
        self.dataProvider = dataProvider
        self.validationTypes = validationTypes
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    public var isValid: Bool {
        return validationErrors.count == .zero
    }
    
    public var validationErrors: [RegisterValidationError] {
        return validationResults.filter({ $0.validationError != nil }).map({ $0.validationError! })
    }
    
    fileprivate var validationResults: [RegisterValidationResult] {
        var result: [RegisterValidationResult] = []
        for type in self.validationTypes {
            switch type {
            case .nickname:
                result.append(RegisterValidationLogic.textIsEmpty(validationType: type,
                                                                  text: dataProvider.nickname))
            case .password,
                 .confirmPassword:
                
                result.append(RegisterValidationLogic.confirmPasswordIsEqualPassword(validationType: type,
                                                                                     confirmPassword: dataProvider.confirmPassword,
                                                                                     password: dataProvider.password))            
            }
        }
        return result
    }
    
}
