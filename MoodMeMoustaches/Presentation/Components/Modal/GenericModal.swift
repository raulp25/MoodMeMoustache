//
//  GenericModal.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import UIKit

protocol GenericModalDelegate: NSObject {
    func didTapLeftBtn()
    func didTapRightBtn()
    func textFieldDidCHange(text: String)
}

class GenericModal: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "description label"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let tagTextField: UITextField = {
       let textField = CustomTextField(placeholder: "Enter tag")
        return textField
    }()
    
    private lazy var leftBtn: UIButton = {
        let btn = CustomButton(viewModel: .init(title: "cancel"))
        btn.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        btn.addTarget(self, action: #selector(didTapLeftBtn), for: .touchUpInside)
        return btn
    }()
    
    private lazy var rightBtn: UIButton = {
        let btn = CustomButton(viewModel: .init(title: "accpet"))
        btn.backgroundColor = #colorLiteral(red: 0.7818982904, green: 0.5797014751, blue: 0.9752335696, alpha: 1)
        btn.addTarget(self, action: #selector(didTapRightBtn), for: .touchUpInside)
        return btn
    }()
    
    private var horizontalPadding: CGFloat = 25
    private var verticalPadding: CGFloat = 15
    
    weak var delegate: GenericModalDelegate?
    private var leftBtnWidth: CGFloat
    private var rightBtnWidth: CGFloat
    
    init(title: String = "Title",
         description: String = "Description",
         textFieldPlaceHolder: String = "Enter tag",
         leftBtnText: String = "cancel",
         leftBtnWidth: CGFloat = 40,
         rightBtnText: String = "accept",
         rightBtnWidth: CGFloat = 40)
    {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.leftBtnWidth = leftBtnWidth
        self.rightBtnWidth = rightBtnWidth
        
        super.init(frame: .zero)
        
        rightBtn.setTitle(rightBtnText, for: .normal)
        leftBtn.setTitle(leftBtnText, for: .normal)
        
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(textFieldDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: tagTextField)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextField.textDidChangeNotification,
                                                  object: nil)
    }
    
    func setupUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(tagTextField)
        addSubview(leftBtn)
        addSubview(rightBtn)
        
        titleLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: verticalPadding
        )
        
        descriptionLabel.anchor(
            left: leftAnchor,
            bottom: tagTextField.topAnchor,
            right: rightAnchor,
            paddingLeft: horizontalPadding,
            paddingBottom: 10,
            paddingRight: horizontalPadding
        )
        
        tagTextField
            .center(inView: self)
        tagTextField.anchor(
            left: leftAnchor,
            right: rightAnchor,
            paddingLeft: horizontalPadding,
            paddingRight: horizontalPadding
        )
        
        leftBtn.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            paddingLeft: horizontalPadding,
            paddingBottom: verticalPadding
        )
        
        leftBtn.setDimensions(height: 40, width: 120)
        
        rightBtn.anchor(
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingBottom: verticalPadding,
            paddingRight: horizontalPadding
        )
        rightBtn.setDimensions(height: 40, width: 120)
    }
    
    @objc func textFieldDidChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField,
                let text = textField.text
        else {
            return
        }
        
            delegate?.textFieldDidCHange(text: text)
        
    }
    
    @objc private func didTapLeftBtn() {
        delegate?.didTapLeftBtn()
    }
    
    @objc private func didTapRightBtn() {
        delegate?.didTapRightBtn()
    }
    
}
