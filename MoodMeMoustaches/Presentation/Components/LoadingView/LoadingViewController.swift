//
//  LoadingViewController.swift
//  pethug
//
//  Created by Raul Pena on 18/09/23.
//

import Foundation

import UIKit

final class LoadingViewController: UIViewController {
    private lazy var spinner = SpinnerView(colors: spinnerColors, lineWidth: 3)

    var spinnerColors: [UIColor]
    init(spinnerColors: [UIColor] = [.red]) {
        self.spinnerColors = spinnerColors
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = customRGBColor(red: 246, green: 246, blue: 246)
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 50).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.spinner.isAnimating = true
        }
    }
}
