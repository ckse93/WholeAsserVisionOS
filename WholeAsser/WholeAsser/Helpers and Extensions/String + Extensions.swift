//
//  String + Extensions.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import Foundation

extension String {
    /// "  Taylor Swift  "  ->  "Taylor Swift"
    func cleaned() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
