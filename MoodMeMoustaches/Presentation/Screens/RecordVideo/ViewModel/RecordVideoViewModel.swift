//
//  RecordVideoViewModel.swift
//  rs5
//
//  Created by Raul Pena on 10/05/24.
//

import UIKit
import SwiftUI
import ARKit


class RecordVideoViewModel {
    let planeWidth: CGFloat = 0.13
    let planeHeight: CGFloat = 0.06
    let nodeYPosition: Float =  -0.022999994
    let minPositionDistance: Float = 0.0025
    let minScaling: CGFloat = 0.025
    let moustachesCount = 6
    let animationDuration: TimeInterval = 0.25
    let cornerRadius: CGFloat = 10
    
    var isRecording = false
    private var scaling: CGFloat = 1
}
