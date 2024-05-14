//
//  Validator.swift
//  pethug
//
//  Created by Raul Pena on 13/09/23.
//

import Combine
import Foundation

protocol Validator {
    func validateText(
        with text: String,
        validationType: ValidatorType
    ) -> ValidationState
}

extension Validator {
    func validateText(
        with text: String,
        validationType: ValidatorType
    ) -> ValidationState {
        let validator = ValidatorFactory.validateForType(type: validationType)
        return validator.validate(text: text)
    }
}


