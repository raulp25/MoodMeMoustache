//
//  FinalPreViewViewController.swift
//  VideoCameraCustom
//
//  Created by Raul Pena on 09/05/24.
//

import UIKit
import AVKit
import AVFoundation

class FinalPreViewViewController: UIViewController {
    lazy private var closeButton: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .white
        iv.image = UIImage(systemName: "cross")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapClose))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    
    private lazy var uploadButton: CustomButton = {
        let btn = CustomButton(viewModel: .init(title: "Upload"))
        btn.backgroundColor = .systemRed
        btn.addTarget(self, action: #selector(didTapUpload), for: .touchUpInside)
        return btn
    }()
    
    var url: URL
    var showPreview: Bool = false
    let player = AVPlayer()
    let controller = AVPlayerViewController()
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated:false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        controller.player = player
        
        let playerItem = AVPlayerItem(url: url)
        
        
        // Set the new player item as current, and begin loading its data.
        player.replaceCurrentItem(with: playerItem)
        
        player.seek(to: .zero, toleranceBefore: .zero, toleranceAfter: .zero)
        
        player.play()
        
        addChild(controller)
        view.addSubview(controller.view)
        view.addSubview(closeButton)
        view.addSubview(uploadButton)
        
//        controller.view.fillSuperview()
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let safeAreaInsets = window?.safeAreaInsets
        
        controller.view.frame = CGRect(x: 0, 
                                       y: safeAreaInsets?.top ?? 0,
                                       width: view.bounds.size.width,
                                       height: view.bounds.size.height - 200)
        controller.view.clipsToBounds = true
        
        controller.view.layer.borderColor =  UIColor.white.cgColor
        controller.view.layer.borderWidth = 2
        controller.view.layer.cornerRadius = 10
        
        closeButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingRight: 15
        )
        closeButton.setDimensions(height: 35, width: 35)
        
        uploadButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 15
        )
    }
    
    
    
    private func configureAudioSession() async {
        let session = AVAudioSession.sharedInstance()
        do {
            // Configure the audio session for playback. Set the `moviePlayback` mode
            // to reduce the audio's dynamic range to help normalize audio levels.
            try session.setCategory(.playback, mode: .moviePlayback)
        } catch {
            print("Unable to configure audio session: => \(error.localizedDescription)")
        }
    }
    
    
    
    @objc private func didTapClose() {
        print(": => did tap close")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapUpload() {
        print(": =>upload tapped")
    }
    
    
    
}

