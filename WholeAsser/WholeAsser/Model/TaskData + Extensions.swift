//
//  TaskData + Extensions.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/16/24.
//

import Foundation
import SwiftUI

enum TaskType: String, Codable, CaseIterable {
    case work = "work"
    case cleaning = "cleaning"
    case chores = "chores"
    case misc = "misc"
    
    var colorPackage: ColorSet {
        switch self {
        case .work:
            let base = ColorPackage(main: .init(hex: "00B6D8"),
                                    popDark: .init(hex: "006477"),
                                    popPale: .init(hex: "1BD8FB"),
                                    accentDark: .init(hex: "008098"),
                                    accentPale: .init(hex: "03D7FF"))
            let complimentary = ColorPackage(main: .init(hex: "FF7C00"),
                                             popDark: .init(hex: "9B4C00"),
                                             popPale: .init(hex: "FF8816"),
                                             accentDark: .init(hex: "C25F00"),
                                             accentPale: .init(hex: "FF8816"))
            return ColorSet(base: base,
                            complimentary: complimentary)
        case .cleaning:
            let base = ColorPackage(main: .init(hex: "A7C957"),
                                    popDark: .init(hex: "628314"),
                                    popPale: .init(hex: "E3F6B8"),
                                    accentDark: .init(hex: "86AA31"),
                                    accentPale: .init(hex: "D0EE8C"))
            let complimentary = ColorPackage(main: .init(hex: "A74884"),
                                             popDark: .init(hex: "6D104A"),
                                             popPale: .init(hex: "DDA6C9"),
                                             accentDark: .init(hex: "8D2968"),
                                             accentPale: .init(hex: "C574A7"))
            return ColorSet(base: base,
                            complimentary: complimentary)
        case .chores:
            let base = ColorPackage(main: .init(hex: "ffbe0b"),
                                    popDark: .init(hex: "A07500"),
                                    popPale: .init(hex: "FFD768"),
                                    accentDark: .init(hex: "CB9500"),
                                    accentPale: .init(hex: "FFCC3F"))
            let complimentary = ColorPackage(main: .init(hex: "1F2AB1"),
                                             popDark: .init(hex: "0C136F"),
                                             popPale: .init(hex: "6269C8"),
                                             accentDark: .init(hex: "131C8D"),
                                             accentPale: .init(hex: "4049B8"))
            return ColorSet(base: base,
                            complimentary: complimentary)

        case .misc:
            let base = ColorPackage(main: .init(hex: "5F0CB8"),
                                    popDark: .init(hex: "38056E"),
                                    popPale: .init(hex: "8A50C8"),
                                    accentDark: .init(hex: "48088D"),
                                    accentPale: .init(hex: "732DBF"))
            let complimentary = ColorPackage(main: .init(hex: "FFDD00"),
                                             popDark: .init(hex: "9B8600"),
                                             popPale: .init(hex: "FFE959"),
                                             accentDark: .init(hex: "FFE32B"),
                                             accentPale: .init(hex: "D0B400"))
            return ColorSet(base: base,
                            complimentary: complimentary)

        }
    }
    
    var completionMessageArray: [String] {
        switch self {
        case .work:
            return [
                "Done! good job! 👏",
                "Done! you should be proud of yourself 👍",
                "Done! nice acheivement! 🏆",
                "Done! that was easy, wasn't it? 😎",
                "Done! let's do it again soon ✨",
                "Awesome! let's do it again soon ⭐️",
                "Awesome! let's do it again soon ✨",
            ]
        case .cleaning:
            return [
                "Done! good job! 👏",
                "Done! you should be proud of yourself 👍",
                "Done! nice acheivement! 🏆",
                "Done! that was easy, wasn't it? 😎",
                "Done! let's do it again soon ✨",
                "Done! looks a LOT better now ✨",
                "Nice!, Look at this, you did it! ✨",
                "You did it! It looks amazing now! 😍",
                "You did it!, let's make this a habit? 😜",
                "Yeah this looks WAY better now 👏",
                "It really wasn't that hard, but look at this! Awesome! 🥳"
            ]
        case .chores:
            return [
                "Done! good job! 👏",
                "Done! you should be proud of yourself 👍",
                "Done! nice acheivement! 🏆",
                "Done! that was easy, wasn't it? 😎",
                "Done! let's do it again soon ✨",
            ]
        case .misc:
            return [
                "Done! good job! 👏",
                "Done! you should be proud of yourself 👍",
                "Done! nice acheivement! 🏆",
                "Done! that was easy, wasn't it? 😎",
                "You did it!, let's make this a habit? 😜",
            ]
        }
    }
}


extension TaskData {
    var totalMinutes: Int {
        let hoursToMin = self.durationHr * 60
        return hoursToMin + self.durationMin
    }
    
    var description: String {
        var desc = ""
        desc.append("title: \(self.title) \n")
        desc.append("icon: \(self.icon) \n")
        desc.append("isFavorite: \(self.isFavorite) \n")
        desc.append("allCompleteCount: \(self.allCompleteCount) \n")
        desc.append("completeCount: \(self.completeCount) \n")
        desc.append("icon: \(self.icon) \n")
        desc.append("durationHr: \(self.durationHr) \n")
        desc.append("durationMin: \(self.durationMin) \n")
        desc.append("taskType: \(self.taskType.rawValue) \n")
        desc.append("MiniGoals: \n")
        for miniGoal in self.miniGoals {
            desc.append("      \(miniGoal)")
        }
        desc.append("\n")
        desc.append("postRaing: \n")
        for rating in self.postTaskRatings {
            desc.append("      \(rating)")
        }
        return desc
    }
}

extension TaskData {
    var taskDurationInSec: Double {
        let totalMins = (durationHr * 60) + totalMinutes
        return Double(totalMins * 60)
    }
}

extension TaskData: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.title)
        hasher.combine(self.isFavorite)
        hasher.combine(self.allCompleteCount)
        hasher.combine(self.durationHr)
        hasher.combine(self.durationMin)
        hasher.combine(self.postTaskRatings)
    }
}

extension TaskData: Equatable {
    static func == (lhs: TaskData, rhs: TaskData) -> Bool {
        return (
            lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.isFavorite == rhs.isFavorite &&
            lhs.allCompleteCount == rhs.allCompleteCount &&
            lhs.completeCount == rhs.completeCount &&
            lhs.durationHr == rhs.durationHr &&
            lhs.durationMin == rhs.durationMin &&
            lhs.postTaskRatings == rhs.postTaskRatings
        )
    }
}
