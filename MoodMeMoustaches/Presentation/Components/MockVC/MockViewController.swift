//
//  MockViewController.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import UIKit

final class MockVC: UIViewController {
    private let textLabel: UILabel = {
       let label = UILabel()
        label.text = "MoodMe 🇺🇸"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7818982904, green: 0.5797014751, blue: 0.9752335696, alpha: 1)
        
        view.addSubview(textLabel)
        
        textLabel.center(inView: view)
    }
}
