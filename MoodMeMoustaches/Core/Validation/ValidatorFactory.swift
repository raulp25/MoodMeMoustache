//  MoodMeMoustaches

import Foundation

// MARK: - Factory
enum ValidatorFactory {
    static func validateForType(type: ValidatorType) -> Validatable {
        switch type {
        case .name:
            return NameValidator()
        }
    }
}
