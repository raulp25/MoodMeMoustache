//  MoodMeMoustaches

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


