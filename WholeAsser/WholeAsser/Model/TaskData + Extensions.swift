//
//  Task.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import Foundation

enum TaskType: String, Codable, CaseIterable {
    case work = "work"
    case cleaning = "cleaning"
    case chores = "chores"
    case misc = "misc"
    
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

//extension TaskData: Codable { }

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
            desc.append("      \(miniGoal)\n")
        }
        desc.append("\n")
        desc.append("postRaing: \n")
        for rating in self.postTaskRatings {
            desc.append("      \(rating)")
        }
        return desc
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

