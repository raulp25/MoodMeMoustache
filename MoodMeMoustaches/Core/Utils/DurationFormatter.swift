//
//  DurationFormatter.swift
//  SportsWatch
//
//  Created by Raul Pena on 11/02/24.
//

import Foundation

/// Return a formatter for durations
var durationFormatter: DateComponentsFormatter {
    let durationFormatter = DateComponentsFormatter()
    durationFormatter.allowedUnits = [.minute, .second]
    durationFormatter.unitsStyle = .positional
    durationFormatter.zeroFormattingBehavior = .pad
    
    return durationFormatter
}
