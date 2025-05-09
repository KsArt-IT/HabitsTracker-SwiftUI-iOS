//
//  ArrayExt.swift
//  HabitsTracker
//
//  Created by KsArT on 09.05.2025.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map { index in
            let end = Swift.min(index + size, count)
            return Array(self[index..<end])
        }
    }
}
