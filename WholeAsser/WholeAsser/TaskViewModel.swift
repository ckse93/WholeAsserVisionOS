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
    var timeSpent = 0.1
    private var timer: Timer?
    
    var timerStatus: TimerStatus = .notStarted
    
    private var elapsedTime: TimeInterval = 0
    private var startTime: Date?
    
    var miniGoals: [MiniGoalViewModel] = [
        .init(title: "Empty trashcan"),
        .init(title: "Pick up the clutters"),
        .init(title: "Organize desk")
    ]
    
    var taskDuration = 10.0
    let min = 0.0
    
    var miniGoalWindows: [String] = []
    
    private func stopTimer() {
        if let startTime = startTime {
            // Stop the timer
            timer?.invalidate()
            elapsedTime += Date().timeIntervalSince(startTime)
            self.startTime = nil
//            self.timeSpent = 0
            self.timerStatus = .done
        }
    }
    
    func startTimer() {
        startTime = Date()
        self.timerStatus = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let startTime = self.startTime {
                self.elapsedTime = Date().timeIntervalSince(startTime)
                self.timeSpent = self.elapsedTime
                if self.elapsedTime >= self.taskDuration {
                    self.stopTimer()
                }
            }
        }
    }
}

extension TaskViewModel {
    @Observable
    class MiniGoalViewModel: Identifiable {
        init(title: String) {
            self.title = title
        }
        let id: UUID = .init()
        var isDone: Bool = false
        var title: String
    }
}
