//  MoodMeMoustaches

import UIKit
import SwiftUI
import ARKit


final class RecordVideoViewModel {
    let planeWidth: CGFloat = 0.13
    let planeHeight: CGFloat = 0.06
    let nodeYPosition: Float =  -0.022999994
    let minPositionDistance: Float = 0.0025
    let minScaling: CGFloat = 0.025
    let moustachesCount = 8
    let animationDuration: TimeInterval = 0.25
    let cornerRadius: CGFloat = 10
    
    var isRecording = false
    private var scaling: CGFloat = 1
    
    
    let moustachesData: [MoustacheData] = [
        MoustacheData(posX: 0.0,    posY: -0.022999994, posZ: 0.061268654, scale: 0.6249999999999997),
        MoustacheData(posX: 0.0,    posY: -0.025499994, posZ: 0.061268654, scale: 0.5249999999999996),
        MoustacheData(posX: 0.0,    posY: -0.025499994, posZ: 0.061268654, scale: 0.49999999999999956),
        MoustacheData(posX: 0.0,    posY: -0.017999995, posZ: 0.061268654, scale: 0.7499999999999998),
        MoustacheData(posX: 0.0,    posY: -0.025499994, posZ: 0.061268654, scale: 0.5749999999999996),
//        MoustacheData(posX: 0.0,    posY: -0.015499996, posZ: 0.61268654,  scale: 0.7499999999999998),
        MoustacheData(posX: 0.0,    posY: -0.020499995, posZ: 0.061268654, scale: 0.8499999999999999),
        MoustacheData(posX: 0.0,    posY: -0.025499994, posZ: 0.061268654, scale: 0.9249999999999999),
        MoustacheData(posX: 0.0025, posY: -0.027999993, posZ: 0.061268654, scale: 0.95)
    ]
    
    
}


struct MoustacheData {
    let posX: Float
    let posY: Float
    let posZ: Float
    let scale: CGFloat
}
