//
//  HomeViewController.swift
//  VideoCameraCustom
//
//  Created by Raul Pena on 09/05/24.
//

import UIKit
import SwiftUI
import ARKit

//import ARVideoKit

class RecordVideoViewController: UIViewController {
    
    private let viewModel = RecordVideoViewModel()
    private lazy var collectionView: UICollectionView = .createDefaultCollectionView(layout: createLayout())
    
    private var sceneView = ARSCNView()
    private var capture: ARCapture?
    
//    var recorder: RecordAR?
    private let glassesPlane: SCNPlane
    private let glassesNode: SCNNode
    
    lazy private var shutterButton: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .white
        iv.image = UIImage(systemName: "timelapse")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRecordVideo))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    
    private var bgView: UIView = {
        let uv = UIView()
        uv.backgroundColor = customRGBColor(red: 161, green: 86, blue: 227)
        uv.layer.cornerRadius = 35
        return uv
    }()
    
    init() {
        self.glassesPlane = SCNPlane(width: viewModel.planeWidth, height: viewModel.planeHeight)
        self.glassesNode = SCNNode()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupARSceneRecorder()
        setupUI()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        recorder?.prepare(configuration)
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        recorder?.rest()
        sceneView.session.pause()
    }
    
    func setupARSceneRecorder() {
        let scene = SCNScene()
        sceneView.scene = scene
        capture = ARCapture(view: sceneView)
        capture?.recordAudio(enable: true)
    }
    
    func setupUI() {
//        view.backgroundColor = .systemPink.withAlphaComponent(0.8)
        view.backgroundColor = .black
//        recorder = RecordAR(ARSceneKit: sceneView)
//        recorder?.fps = .fps60
        view.addSubview(sceneView)
        view.addSubview(collectionView)
        view.addSubview(bgView)
        bgView.addSubview(shutterButton)
        
        sceneView.delegate = self
        sceneView.frame = CGRect(x: 0, 
                                 y: 0,
                                 width: view.frame.size.width,
                                 height: view.frame .size.height - 200)
        sceneView.clipsToBounds = true
        sceneView.layer.borderColor =  UIColor.white.cgColor
        sceneView.layer.borderWidth = 2
        sceneView.layer.cornerRadius = 10
        
        bgView.centerX(
            inView: view
        )
        bgView.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingBottom: 10
        )
        bgView.setDimensions(height: 70, width: 70)
        
        shutterButton.center(
            inView: bgView
        )
        shutterButton.setDimensions(height: 35, width: 35)
        collectionView.anchor(
            left: view.leftAnchor,
            bottom: bgView.topAnchor,
            right: view.rightAnchor,
            paddingBottom: 15
        )
        collectionView.setHeight(110)
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.bounces = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(MoustachesCollectionViewCell.self, forCellWithReuseIdentifier: MoustachesCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 110)
        layout.minimumLineSpacing = 20
        return layout
    }
    
    private func updateGlasses(with index: Int) {
        let imageName = "moustache\(index)"
        glassesPlane.firstMaterial?.diffuse.contents = UIImage(named: imageName)
    }
    
    @objc private func didTapRecordVideo() {
        if viewModel.isRecording {
//            recorder?.stop({ url in
//                print("url: => \(url)")
//                               DispatchQueue.main.async { [weak self] in
//                                   self?.isRecording = false
//                                   
//                                   let vc = FinalPreViewViewController(url: url)
//                                   self?.navigationController?.pushViewController(vc, animated: true)
//                               }
//            })
            // TODO: when user taps to upload the video we should delete it from the temporary url
           ///       at the end by useing the filemanager delete item at url
            capture?.stop({ url in
                print("status: => \(String(describing: url))")
                DispatchQueue.main.async { [weak self] in
                    guard let url = url else { return }
                    let vc = FinalPreViewViewController(url: url)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
            viewModel.isRecording = false
            bgView.backgroundColor = customRGBColor(red: 161, green: 86, blue: 227)
        } else {
//            recorder?.record()
//            capture?.recordAudio(enable: true)
            capture?.start()
//            capture?.recordAudio(enable: true)
            viewModel.isRecording = true
            bgView.backgroundColor = .black
        }
        
        print(": => recording tap my g")
    }
    
}

extension RecordVideoViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else {
            return nil
        }
        
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let faceNode = SCNNode(geometry: faceGeometry)
        faceNode.geometry?.firstMaterial?.transparency = 0
        
        glassesPlane.firstMaterial?.isDoubleSided = true
        updateGlasses(with: 0)
        
        glassesNode.position.z = faceNode.boundingBox.max.z * 3 / 4
        glassesNode.position.y = viewModel.nodeYPosition
        glassesNode.geometry = glassesPlane

        faceNode.addChildNode(glassesNode)
        
        return faceNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
            return
        }
        
        faceGeometry.update(from: faceAnchor.geometry)
    }
}


extension RecordVideoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.moustachesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoustachesCollectionViewCell.identifier, for: indexPath) as? MoustachesCollectionViewCell else {
            fatalError("Couldn't find moustache cell at RecordVideoController")
        }
        let imageName = "moustache\(indexPath.row)"
        cell.configure(with: imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(":cell clicked => ")
        updateGlasses(with: indexPath.row)
    }
}



struct RecordVideoRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RecordVideoViewController {
        RecordVideoViewController()
    }
    
    func updateUIViewController(_ uiViewController: RecordVideoViewController, context: Context) {
        
    }
    
typealias UIViewControllerType = RecordVideoViewController

}

struct ViewController_Previews2: PreviewProvider {
    static var previews: some View {
        RecordVideoRepresentable()
    }
}

