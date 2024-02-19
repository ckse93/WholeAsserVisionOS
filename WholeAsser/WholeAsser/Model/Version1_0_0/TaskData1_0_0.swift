//
//  TaskDataV1_0_0.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/14/24.
//

import CloudKit
import Foundation
import SwiftData

extension SchemaV1_0_0 {
    @Model
    final class TaskData: Identifiable, Codable {
        var id: String = UUID().uuidString
        var title: String = ""
        var icon: String = "🗑️"
        var isFavorite: Bool = false
        var allCompleteCount: Int = 0
        var completeCount: Int = 0
        var durationMin: Int = 1
        var durationHr: Int = 0
        var miniGoals: [String] = []
        var postTaskRatings: [String] = []
        var taskType: TaskType = TaskType.misc
        var createdDate: Date = Date()
        var lastCompleteDate: Date?
        
        init(title: String,
             icon: String,
             isFavorite: Bool = false,
             durationMin: Int,
             durationHr: Int,
             miniGoals: [String],
             taskType: TaskType
        ) {
            self.id = UUID().uuidString
            self.title = title
            self.icon = icon
            self.isFavorite = isFavorite
            self.allCompleteCount = 0
            self.completeCount = 0
            self.durationMin = durationMin
            self.durationHr = durationHr
            self.miniGoals = miniGoals
            self.postTaskRatings = []
            self.taskType = taskType
            self.createdDate = Date()
        }
        
        // codable conformance
        enum CodingKeys: CodingKey {
            case id
            case title
            case icon
            case isFavorite
            case allCompleteCount
            case completeCount
            case durationMin
            case durationHr
            case miniGoals
            case postTaskRatings
            case taskType
            case createdDate
            case lastCompleteDate
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            icon = try container.decode(String.self, forKey: .icon)
            isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
            allCompleteCount = try container.decode(Int.self, forKey: .allCompleteCount)
            completeCount = try container.decode(Int.self, forKey: .completeCount)
            durationMin = try container.decode(Int.self, forKey: .durationMin)
            durationHr = try container.decode(Int.self, forKey: .durationHr)
            miniGoals = try container.decode([String].self, forKey: .miniGoals)
            postTaskRatings = try container.decode([String].self, forKey: .postTaskRatings)
            taskType = try container.decode(TaskType.self, forKey: .taskType)
            createdDate = try container.decode(Date.self, forKey: .createdDate)
            lastCompleteDate = try container.decodeIfPresent(Date.self, forKey: .lastCompleteDate)

            // Default values for properties not included in the decoder
            if container.contains(.title) == false {
                title = ""
            }
            if container.contains(.icon) == false {
                icon = "🗑️"
            }
            if container.contains(.isFavorite) == false {
                isFavorite = false
            }
            if container.contains(.allCompleteCount) == false {
                allCompleteCount = 0
            }
            if container.contains(.completeCount) == false {
                completeCount = 0
            }
            if container.contains(.durationMin) == false {
                durationMin = 1
            }
            if container.contains(.durationHr) == false {
                durationHr = 0
            }
            if container.contains(.miniGoals) == false {
                miniGoals = []
            }
            if container.contains(.postTaskRatings) == false {
                postTaskRatings = []
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(icon, forKey: .icon)
            try container.encode(isFavorite, forKey: .isFavorite)
            try container.encode(allCompleteCount, forKey: .allCompleteCount)
            try container.encode(completeCount, forKey: .completeCount)
            try container.encode(durationMin, forKey: .durationMin)
            try container.encode(durationHr, forKey: .durationHr)
            try container.encode(miniGoals, forKey: .miniGoals)
            try container.encode(postTaskRatings, forKey: .postTaskRatings)
            try container.encode(taskType, forKey: .taskType)
            try container.encode(createdDate, forKey: .createdDate)
            try container.encodeIfPresent(lastCompleteDate, forKey: .lastCompleteDate)
        }
    }
}
