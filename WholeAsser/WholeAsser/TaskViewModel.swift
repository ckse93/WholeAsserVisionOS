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

@Observable
final class TaskViewModel {
    init(taskData: TaskData) {
        self.taskData = taskData
        self.timeSpent = 0.1
        self.timer = nil
        self.timerStatus = .notStarted
        self.elapsedTime = 0
        self.startTime = nil
        taskData.resetMiniGoals()
    }
    
    var taskData: TaskData
    
    var timeSpent: Double
    private var timer: Timer?
    
    var timerStatus: TimerStatus
    
    private var elapsedTime: TimeInterval
    private var startTime: Date?
    
    var showRatingView: Bool = false
    var showWarningAlert: Bool = false
    
    var taskDurationInSec: Double {
        Double(taskData.totalMinutes * 60)
    }
    
    let minimum = 0.0
    
    var selectedRating: String?
    
    private func stopTimer() {
        if let startTime = startTime {
            // Stop the timer
            timer?.invalidate()
            elapsedTime += Date().timeIntervalSince(startTime)
            self.startTime = nil
            self.timerStatus = .done
            self.showRatingView = true
        }
    }
    
    func startTimer() {
        startTime = Date()
        self.timerStatus = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let startTime = self.startTime {
                self.elapsedTime = Date().timeIntervalSince(startTime)
                self.timeSpent = self.elapsedTime
                if self.elapsedTime >= self.taskDurationInSec {
                    self.stopTimer()
                }
            }
        }
    }
    
    func doneButtonAction() {
        stopTimer()
    }
    
    func updatePostRating() {
        if let rating = self.selectedRating {
            taskData.postTaskRatings.append(rating)
        }
    }
}
