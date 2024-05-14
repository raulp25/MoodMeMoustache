//
//  DummyView.swift
//  pethug
//
//  Created by Raul Pena on 16/09/23.
//

import UIKit

class DummyView: UIViewController {
    
    init(hidesKeyBoardWhenTappedAround: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        if hidesKeyBoardWhenTappedAround {
            hideKeyboardWhenTappedAround()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = customRGBColor(red: 58, green: 91, blue: 144)
    }
}
