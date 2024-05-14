//
//  FinalPreViewViewController.swift
//  VideoCameraCustom
//
//  Created by Raul Pena on 09/05/24.
//

import UIKit
import AVKit
import AVFoundation

final class FinalPreViewViewController: UIViewController {
    let viewModel = FinalPreViewViewModel()
    let player = Player()
    
    private let dummyView = DummyView(hidesKeyBoardWhenTappedAround: true)
    private let loadingView = LoadingViewController(spinnerColors: [#colorLiteral(red: 0.7818982904, green: 0.5797014751, blue: 0.9752335696, alpha: 1)])
    
    lazy private var closeBtn: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        iv.image = UIImage(systemName: "xmark")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapClose))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    
    private lazy var closeBtnBackgroundView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .black
        uv.layer.cornerRadius = 20
        uv.layer.borderColor = UIColor.black.withAlphaComponent(0.8) .cgColor
        uv.layer.borderWidth = 1.2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapClose))
        uv.isUserInteractionEnabled = true
        uv.addGestureRecognizer(tapGesture)
        return uv
    }()
    
    private lazy var nextButton: CustomButton = {
        let btn = CustomButton(viewModel: .init(title: "Next"))
        btn.backgroundColor = #colorLiteral(red: 0.7818982904, green: 0.5797014751, blue: 0.9752335696, alpha: 1)
        btn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return btn
    }()
    
    let controller = AVPlayerViewController()
    var url: URL
    var showPreview: Bool = false
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Remove the recorded video url that was stored in a temp directory
        // since we don't need it anymore at this point
        removeFileFromTempFolder(url: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        controller.player = player.player
        
        Task{ await player.loadVideo(with: url) }
        
        addChild(controller)
        view.addSubview(controller.view)
        view.addSubview(closeBtnBackgroundView)
        closeBtnBackgroundView.addSubview(closeBtn)
        view.addSubview(nextButton)
        

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
        
        
        closeBtnBackgroundView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingRight: 15
        )
        closeBtnBackgroundView.setDimensions(height: 40, width: 40)
        
        closeBtn.center(
            inView: closeBtnBackgroundView
        )
        closeBtn.setDimensions(height: 20, width: 20)
        
        
        nextButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 15
        )
    }
    
    @objc private func didTapClose() {
        print(": => did tap close")
        dismissVC()
    }
    
    @objc private func didTapNext() {
        print(": =>upload tapped")
        showModal()
    }
    
    
    private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setLoadingScreen() {
        view.isUserInteractionEnabled = false
        
        add(loadingView)
        view.bringSubviewToFront(loadingView.view)
        loadingView.view.fillSuperview()
        loadingView.view.backgroundColor = .clear
    }
    
    private func removeLoadingScreen() {
        view.isUserInteractionEnabled = true
        
        loadingView.remove()
    }
}

extension FinalPreViewViewController {
    func showModal() {
        let uploadVideoView = GenericModal(title: "Video tag",
                                         description: "Set your video tag",
                                         leftBtnWidth: 100,
                                         rightBtnWidth: 100)
        uploadVideoView.delegate = self
        
        
        add(dummyView)
        self.view.bringSubviewToFront(dummyView.view)
        dummyView.view.addSubview(uploadVideoView)

        dummyView.view.fillSuperview()
        dummyView.view.alpha = 0
        dummyView.view.backgroundColor = .black.withAlphaComponent(0.3)
        
        uploadVideoView
            .center(inView: dummyView.view)
        uploadVideoView.setDimensions(height: 290, width: view.frame.size.width / 1.3)
        uploadVideoView.backgroundColor = .white
        uploadVideoView.layer.cornerRadius = 15
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.dummyView.view.alpha = 1
        }
        self.view.layoutIfNeeded()
    }
    
    func dismissModal() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.dummyView.view.alpha = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self?.dummyView.remove()
                self?.view.layoutIfNeeded()
            })
        }
    }
}

extension FinalPreViewViewController: GenericModalDelegate {
    func didTapLeftBtn() {
        print("DEBUG: tapped left button => ")
        dismissModal()
    }
    
    func didTapRightBtn() {
        dismissModal()
        setLoadingScreen()
        Task {
            await viewModel.uploadVideo(url: url, duration: player.itemDuration, tag: viewModel.tag)
            DispatchQueue.main.async { [weak self] in
                self?.removeLoadingScreen()
                self?.dismissVC()
            }
        }
    }
    
    func textFieldDidCHange(text: String) {
        viewModel.tag = text.trimWhiteSpaces()
    }
}
