//
//  TaskViewModel.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import Foundation
import SwiftUI

enum TimerStatus {
    case notStarted
    case running
    case done
}

enum FetchStatus {
    case loading
    case success(TaskData)
    case failed
}

@Observable
final class TaskViewModel {
    init(taskData: TaskData) {
        self.taskData = taskData
        self.timerStatus = .notStarted
    }
    var timerStatus: TimerStatus
    var taskData: TaskData

    var showRatingView: Bool = false
    var showWarningAlert: Bool = false
    
    var taskDurationInSec: Double {
        Double(taskData.totalMinutes * 60)
    }
    
    let minimum = 0.0
    
    var selectedRating: String?
    
    func updatePostRating() {
        if let rating = self.selectedRating {
            taskData.postTaskRatings.append(rating)
        }
    }
}
