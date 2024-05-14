//
//  RemoveFileFromTempFolder.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import Foundation


func removeFileFromTempFolder(url: URL) {
    do {
        try FileManager.default.removeItem(at: url)
    } catch {
        print("DEBUG: error deleting url removeFileFromTempFolder() => \(error.localizedDescription)")
    }
}
