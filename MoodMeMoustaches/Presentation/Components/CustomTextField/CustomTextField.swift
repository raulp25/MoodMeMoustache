//
//  CustomTextField.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import UIKit

//MARK: - CustomTextField
final class CustomTextField: UITextField {
    
    //MARK: - Private Property
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    private var showShadow: Bool
    
    //MARK: - Initializers
    init(placeholder: String, showShadow: Bool = false) {
        self.showShadow = showShadow
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    //MARK: - Private Methods
    private func setupTextField(placeholder: String) {
        textColor = .white
        
        layer.cornerRadius = 10
        layer.backgroundColor = #colorLiteral(red: 0.7818982904, green: 0.5797014751, blue: 0.9752335696, alpha: 1)
        
        if showShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 7
            layer.shadowOpacity = 0.4
            layer.shadowOffset = CGSize(width: 15, height: 15)
            
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemCyan])
        font = .boldSystemFont(ofSize: 16)
        
        setHeight(50)
    }
    
}
