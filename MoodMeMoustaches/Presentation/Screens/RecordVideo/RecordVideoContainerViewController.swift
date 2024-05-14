//  MoodMeMoustaches

import UIKit

final class RecordVideoContainerViewController: UIViewController {
    
    private let recordVideoVC = RecordVideoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        add(recordVideoVC)
        
        recordVideoVC.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor
        )
    }
}
