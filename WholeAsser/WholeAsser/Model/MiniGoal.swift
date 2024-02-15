//
//  MiniGoal.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/14/24.
//

import SwiftUI

@Observable
final class MiniGoal: Identifiable, Codable {
    var id: UUID = .init()
    var title: String = ""
    var isDone: Bool = false
    
    init(title: String) {
        self.title = title
        self.isDone = false
    }
}

extension MiniGoal: Equatable {
    static func == (lhs: MiniGoal, rhs: MiniGoal) -> Bool {
        return (
            lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.isDone == rhs.isDone
        )
    }
}
