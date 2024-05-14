//
//  EditVideoViewController.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import UIKit
import AVKit

protocol EditVideoDelegate: NSObject {
    func didSaved(tag: String, for videoIndex: Int)
}


final class EditVideoViewController: UIViewController {
    private let viewModel: EditVideoViewModel
    
    private let player = Player()
    
    private var videoPlayer: GenericVideoPlayerViewController?
    
    private lazy var backBtn: UIButton = {
        let button = UIButton.createIconButton(icon: "chevron.backward", size: 16, color: .white)
        button.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
        return button
    }()
    
    private let navTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Edit video"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    // Needed to let videoPlayer Frame adjust correctly and appear on screen
    private let emptyViewToAnchorVideoPlayer: UIView = {
       let uv = UIView()
        return uv
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Edit your video tag"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let tagTextField: UITextField = {
       let textField = CustomTextField(placeholder: "Enter tag")
        return textField
    }()
    
    private lazy var saveButton: CustomButton = {
        let btn = CustomButton(viewModel: .init(title: "Save"))
        btn.backgroundColor = #colorLiteral(red: 0.7818982904, green: 0.5797014751, blue: 0.9752335696, alpha: 1)
        btn.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        return btn
    }()

    private let horizontalPadding: CGFloat = 15
    private var url: String
    weak var delegate: EditVideoDelegate?
    
    init(viewModel: EditVideoViewModel) {
        self.viewModel = viewModel
        self.url = viewModel.video.videoUrl
        self.tagTextField.text = viewModel.video.tag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        loadVideoPlayerVC(url: url)
        setupUI()
    }
    
    func loadVideoPlayerVC(url: String) {
        if let url = URL(string: url) {
            self.videoPlayer = GenericVideoPlayerViewController(url: url)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .black
        view.addSubview(backBtn)
        view.addSubview(navTitleLabel)
        if videoPlayer != nil {
            add(videoPlayer!)
        }
        view.addSubview(emptyViewToAnchorVideoPlayer)
        view.addSubview(descriptionLabel)
        view.addSubview(tagTextField)
        view.addSubview(saveButton)
        
        backBtn.centerY(
            inView: navTitleLabel,
            leftAnchor: view.leftAnchor,
            paddingLeft: 15
        )
        
        navTitleLabel.centerX(
            inView: view,
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 5
        )
        
        if videoPlayer != nil {
            videoPlayer!.view.anchor(
                top: navTitleLabel.bottomAnchor,
                left: view.leftAnchor,
                right: view.rightAnchor,
                paddingTop: 20,
                paddingLeft: horizontalPadding,
                paddingRight: horizontalPadding
            )
            videoPlayer?.view
                .setHeight(300)
        }
        
        descriptionLabel.anchor(
            top: videoPlayer?.view.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 30,
            paddingLeft: horizontalPadding,
            paddingBottom: 5,
            paddingRight: horizontalPadding
        )
        
        tagTextField.anchor(
            top: descriptionLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 5,
            paddingLeft: horizontalPadding,
            paddingRight: horizontalPadding
        )
     
        
        saveButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 10
        )
    }
    
    @objc private func didTapBackBtn() {
        dismissVC()
    }
    
    @objc private func didTapSave() {
        guard let text = tagTextField.text else { return }
        Task {
            await viewModel.update(tag: text, video: viewModel.video)
            DispatchQueue.main.async { [weak self] in
                guard let videoIndex = self?.viewModel.videoIndex else { return }
                self?.delegate?.didSaved(tag: text, for: videoIndex)
                self?.dismissVC()
            }
        }
    }
    
    private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}
