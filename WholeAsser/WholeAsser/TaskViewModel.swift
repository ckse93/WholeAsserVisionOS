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
    init() {
        self.fetchStatus = .loading
        self.timerStatus = .notStarted
    }
    var timerStatus: TimerStatus
    var fetchStatus: FetchStatus
    var taskData: TaskData?

    var showRatingView: Bool = false
    var showWarningAlert: Bool = false
    
    let minimum = 0.0
    
    var selectedRating: String?
    
    func reset() {
        self.timerStatus = .notStarted
        self.showRatingView = false
        self.showWarningAlert = false
    }
    
//    func updatePostRating() {
//        if let taskData = self.taskData,
//           let rating = self.selectedRating {
//            taskData.postTaskRatings.append(rating)
//        }
//    }
}
