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
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "description label"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let tagTextField: UITextField = {
       let textField = CustomTextField(placeholder: "Enter tag")
        return textField
    }()
    
    private lazy var leftBtn: UIButton = {
        let btn = UIButton.createTextButton(with: "cancel", fontSize: 13, color: UIColor.orange)
        btn.addTarget(self, action: #selector(didTapLeftBtn), for: .touchUpInside)
        return btn
    }()
    
    private lazy var rightBtn: UIButton = {
        let btn = UIButton.createTextButton(with: "accept", fontSize: 13, color: UIColor.purple)
        btn.addTarget(self, action: #selector(didTapRightBtn), for: .touchUpInside)
        return btn
    }()
    
    private var horizontalPadding: CGFloat = 10
    private var verticallPadding: CGFloat = 5
    
    weak var delegate: GenericModalDelegate?
    private var leftBtnWidth: CGFloat
    private var rightBtnWidth: CGFloat
    
    init(title: String = "Title",
         description: String = "Description",
         textFieldPlaceHolder: String = "Enter tag",
         leftBtnText: String = "cancel",
         leftBtnWidth: CGFloat = 50,
         rightBtnText: String = "accept",
         rightBtnWidth: CGFloat = 50)
    {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.leftBtnWidth = leftBtnWidth
        self.rightBtnWidth = rightBtnWidth
        
        super.init(frame: .zero)
        
        rightBtn.setTitle(rightBtnText, for: .normal)
        leftBtn.setTitle(leftBtnText, for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: UITextField.textDidChangeNotification, object: tagTextField)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(leftBtn)
        addSubview(rightBtn)
        
        titleLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: verticallPadding
        )
        
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 10
        )
        
        leftBtn.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            paddingLeft: horizontalPadding,
            paddingBottom: verticallPadding
        )
        
        rightBtn.anchor(
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingBottom: verticallPadding,
            paddingRight: horizontalPadding
        )
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
