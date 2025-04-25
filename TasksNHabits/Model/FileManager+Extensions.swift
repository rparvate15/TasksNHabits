//
//  FileManager+Extensions.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 4/25/25.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
