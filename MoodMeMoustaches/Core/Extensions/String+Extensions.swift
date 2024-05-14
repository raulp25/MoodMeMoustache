//  MoodMeMoustaches

import UIKit

// MARK: - Predicates
extension String {
    func hasUppecaseCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[A-Z]+.*")
    }

    func hasLowercaseCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[a-z].*")
    }

    func hasNumbers() -> Bool {
        return stringFulfillsRegex(regex: ".*[0-9].*")
    }

    func hasSpecialCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[^A-Za-z0-9].*")
    }

    func isValidEmail() -> Bool {
        return stringFulfillsRegex(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }

    func isPhoneNumValid() -> Bool {
        return stringFulfillsRegex(regex: "^[0-9+]{0,1}+[0-9]{5,16}$")
    }

    private func stringFulfillsRegex(regex: String) -> Bool {
        let texttest = NSPredicate(format: "SELF MATCHES %@", regex)
        guard texttest.evaluate(with: self) else {
            return false
        }
        return true
    }
}

extension String {
    func validateText(
        validationType: ValidatorType
    ) -> ValidationState {
        let validator = ValidatorFactory.validateForType(type: validationType)
        return validator.validate(text: self)
    }
}

extension String {
    func trimWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}

