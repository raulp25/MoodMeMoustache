//  MoodMeMoustaches

import Foundation

/// Return a formatter for durations
var durationFormatter: DateComponentsFormatter {
    let durationFormatter = DateComponentsFormatter()
    durationFormatter.allowedUnits = [.minute, .second]
    durationFormatter.unitsStyle = .positional
    durationFormatter.zeroFormattingBehavior = .pad
    
    return durationFormatter
}
