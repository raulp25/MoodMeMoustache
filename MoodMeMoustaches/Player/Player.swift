//
//  Player.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 13/05/24.
//

import Foundation
import AVKit
import Combine

final class Player {
    
    let player = AVPlayer()
    var itemDuration: Double = 0
    var isLoadingVideo = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    init() {
        addItemDurationPublisher()
    }
    
    func loadVideo(with url: URL) async {
        defer { isLoadingVideo = false }
        isLoadingVideo = true
        
        await loadPlayerItem(url)
        
        DispatchQueue.main.async { [weak self] in
            self?.player.seek(to: .zero, toleranceBefore: .zero, toleranceAfter: .zero)
            self?.player.play()
        }
    }
    
    private func loadPlayerItem(_ videoURL: URL) async {
        
        let asset = AVAsset(url: videoURL)
        do {
            let (_, _, _) = try await asset.load(.tracks, .duration, .preferredTransform)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let item = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: item)
        
    }
    
    private func addItemDurationPublisher() {
        player
            .publisher(for: \.currentItem?.duration)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (newStatus) in
                guard let newStatus = newStatus,
                      let self = self
                else { return }
                self.itemDuration = newStatus.seconds
                isLoadingVideo = false
            })
            .store(in: &subscriptions)
    }
    
}
