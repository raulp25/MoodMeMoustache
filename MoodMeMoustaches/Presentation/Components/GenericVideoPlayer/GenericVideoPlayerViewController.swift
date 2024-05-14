//
//  GenericVideoPlayerViewController.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import UIKit
import AVKit

class GenericVideoPlayerViewController: UIViewController {
    let player = Player()
    let controller = AVPlayerViewController()
    var url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        controller.player = player.player
        
        Task{ await player.loadVideo(with: url) }
        
        addChild(controller)
        view.addSubview(controller.view)
        controller.view.clipsToBounds = true
        
        controller.view.frame = CGRect(x: 0,
                                       y: 0,
                                       width:  view.bounds.size.width,
                                       height: view.bounds.size.height)
        
        controller.view.layer.borderColor =  UIColor.white.cgColor
        controller.view.layer.borderWidth = 2
        controller.view.layer.cornerRadius = 10
    }

}
