//
//  Validatable.swift
//  pethug
//
//  Created by Raul Pena on 13/09/23.
//

import Combine
import UIKit

// MARK: - Validatable
protocol Validatable {
    func validate(text: String) -> ValidationState
}

// MARK: - Validation Publishers
extension Validatable {
    func isEmpty(with text: String) -> Bool {
        text.isEmpty
    }

    func isToShort(with text: String, count: Int) -> Bool {
        !(text.count >= count)
    }
    
    func isToLong(with text: String, count: Int) -> Bool {
        text.count >= count
    }

    func hasNumbers(with text: String) -> Bool {
        text.hasNumbers()
    }

    func hasLetters(with text: String) -> Bool {
        text.contains(where: { $0.isLetter })
    }
    func hasSpecialChars(with text: String) -> Bool {
        text.hasSpecialCharacters()
    }

    func isEmail(with text: String) -> Bool {
        text.isValidEmail()
    }
    func isPhoneNumber(with text: String) -> Bool {
        text.isPhoneNumValid()
    }
}

// MARK: - Custom Validations
// We only care about empty names or empty titles since doctors don't need the app to stopping them since they are super bussy in hospital
// Bussiness rules might change so we'll wait until that day
struct NameValidator: Validatable {
    func validate(
        text: String
    ) -> ValidationState {
        if isEmpty(with: text) { return .error(.empty) }
        return .valid
    }
}

