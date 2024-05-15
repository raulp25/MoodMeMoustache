//
//  VideoFeedViewController.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import UIKit

final class VideoFeedViewController: UIViewController {
    private let viewModel = VideoFeedViewModel(service: VideoFeedService())
    private let loadingView = LoadingViewController(spinnerColors: [#colorLiteral(red: 0.7818982904, green: 0.5797014751, blue: 0.9752335696, alpha: 1)])
    
    private let navTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "MoodMe 🇺🇸"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var createVideoButtonContainerUIView: UIView = {
        let uv = UIView()
        uv.layer.cornerRadius = 10
        uv.backgroundColor = #colorLiteral(red: 0.7818982904, green: 0.5797014751, blue: 0.9752335696, alpha: 1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCreateVideo))
        uv.isUserInteractionEnabled = true
        uv.addGestureRecognizer(tapGesture)
        return uv
    }()
    
    private let createVideoButtonLabel: UILabel = {
       let label = UILabel()
        label.text = "Record"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    lazy private var createVideoButtonImageView: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        iv.image = UIImage(systemName: "timelapse")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCreateVideo))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .black
        cv.allowsSelection = true
        cv.register(VideoFeedCollectionViewCell.self, forCellWithReuseIdentifier: VideoFeedCollectionViewCell.identifier)
        return cv
    }()
    
    private lazy var refresher: UIRefreshControl = {
       let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    
    private let horizontalPadding: CGFloat = 10
    private let buttonContentHorizontalPadding: CGFloat = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupDelegates()
        setLoadingScreen()
        Task{
            await viewModel.getAllVideos()
            if !viewModel.isLoading {
                DispatchQueue.main.async { [weak self] in
                    self?.removeLoadingScreen()
                }
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(navTitleLabel)
        view.addSubview(createVideoButtonContainerUIView)
        createVideoButtonContainerUIView.addSubview(createVideoButtonLabel)
        createVideoButtonContainerUIView.addSubview(createVideoButtonImageView)
        view.addSubview(collectionView)
        
        navTitleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            paddingTop: 5,
            paddingLeft: horizontalPadding
        )
        
        createVideoButtonContainerUIView
            .centerY(inView: navTitleLabel)
        createVideoButtonContainerUIView.anchor(
            right: view.rightAnchor,
            paddingRight: horizontalPadding
        )
        createVideoButtonContainerUIView
            .setDimensions(height: 30, width: 95)
        
        createVideoButtonLabel.anchor(
            top: createVideoButtonContainerUIView.topAnchor,
            left: createVideoButtonContainerUIView.leftAnchor,
            bottom: createVideoButtonContainerUIView.bottomAnchor,
            paddingLeft: buttonContentHorizontalPadding
        )
        
        createVideoButtonImageView.anchor(
            top: createVideoButtonContainerUIView.topAnchor,
            bottom: createVideoButtonContainerUIView.bottomAnchor,
            right: createVideoButtonContainerUIView.rightAnchor,
            paddingRight: buttonContentHorizontalPadding
        )
        
        collectionView.anchor(
            top: navTitleLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 10
        )

    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refresher
    }
    
    private func setupDelegates() {
        viewModel.delegate = self
    }
    
    @objc private func handleRefresh() {
        Task{ await viewModel.getAllVideos() }
        refresher.endRefreshing()
    }
    
    @objc private func didTapCreateVideo() {
        if let tabBarController = self.tabBarController {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
                tabBarController.selectedIndex = 1
            }
        }
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

extension VideoFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.videos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoFeedCollectionViewCell.identifier, for: indexPath) as? VideoFeedCollectionViewCell else {
            fatalError("RocketListCollectionViewVC's collectionview failed to dequeue cell RocketListCollectionCell")
        }
        
        let video = viewModel.videos[indexPath.row]
        
        cell.configure(with: video)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let video = viewModel.videos[indexPath.row]
        let vc = EditVideoViewController(viewModel: EditVideoViewModel(video: video, 
                                                                       videoIndex: indexPath.row,
                                                                       service: VideoFeedService()))
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension VideoFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2) - 14, height: (view.frame.size.width/2) - 14) // 14 = insets left + right
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 7, bottom: 1, right: 7)
    }
}

extension VideoFeedViewController: VideoFeedViewModelDelegate {
    func videosDidChange() {
        DispatchQueue.main.async{ [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension VideoFeedViewController: EditVideoDelegate {
    func didSaved(tag: String, for videoIndex: Int) {
        viewModel.update(tag: tag, for: videoIndex)
    }
}
