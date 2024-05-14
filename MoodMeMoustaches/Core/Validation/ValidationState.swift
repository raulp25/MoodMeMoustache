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
                return "Campo vacío"
            case .invalidEmail:
                return "Correo inválido"
            case .invalidPhoneNum:
                return "Numero de telefono inválido"
            case .toShortPassword:
                return "Contraseña corta"
            case .passwordNeedsNum:
                return "Contraseña debe incluir un número"
            case .passwordNeedsLetters:
                return "Contraseña debe incluir letras"
            case .nameCantHaveNumOrSpecialChars:
                return "Sin espacios o carácteres espciales"
            case .passwordCantHaveSpacesOrSpecialChars:
                return "Sin espacios o carácteres especiales"
            case .toShortName:
                return "Mínimo 2 letras"
            case .toLongName:
                return "Máximo 12 letras"
            case let .custom(text):
                return text
            }
        }
    }
}
