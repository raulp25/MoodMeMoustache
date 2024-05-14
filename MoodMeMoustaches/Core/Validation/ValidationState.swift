//
//  ValidationState.swift
//  pethug
//
//  Created by Raul Pena on 13/09/23.
//

import Foundation

//MARK: - States
enum ValidationState: Equatable {
    case idle
    case error(ErrorState)
    case valid

    enum ErrorState: Equatable {
        case empty
        case invalidEmail
        case invalidPhoneNum
        case toShortPassword
        case passwordNeedsNum
        case passwordNeedsLetters
        case passwordCantHaveSpacesOrSpecialChars
        case nameCantHaveNumOrSpecialChars
        case toShortName
        case toLongName
        case custom(String)

        var description: String {
            switch self {
            case .empty:
                return "Empty field"
            case .invalidEmail:
                return "Invalid email"
            case .invalidPhoneNum:
                return "Ivalid phone number"
            case .toShortPassword:
                return "Wrong password"
            case .passwordNeedsNum:
                return "Password must contain one number"
            case .passwordNeedsLetters:
                return "Password must contain letters"
            case .nameCantHaveNumOrSpecialChars:
                return "No spaces or spetial characters"
            case .passwordCantHaveSpacesOrSpecialChars:
                return "No spaces or spetial characters"
            case .toShortName:
                return "Min 2 characters"
            case .toLongName:
                return "Max 12 characters"
            case let .custom(text):
                return text
            }
        }
    }
}
