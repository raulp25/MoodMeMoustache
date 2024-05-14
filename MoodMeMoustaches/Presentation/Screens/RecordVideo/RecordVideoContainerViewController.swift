//
//  RecordVideoContainerViewController.swift
//  rs5
//
//  Created by Raul Pena on 10/05/24.
//

import UIKit

final class RecordVideoContainerViewController: UIViewController {
    
    let recordVideoVC = RecordVideoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(recordVideoVC)
        
        recordVideoVC.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor
        )
        
    }
}
