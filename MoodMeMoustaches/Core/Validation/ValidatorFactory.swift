//
//  ValidatorFactory.swift
//  pethug
//
//  Created by Raul Pena on 13/09/23.
//

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
