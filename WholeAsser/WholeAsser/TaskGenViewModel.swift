//
//  TaskGenViewModel.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
final class TaskGenViewModel {
    var title: String = ""
    var icon: String = "🧹"
    var durationMin: Int = 3
    var durationHr: Int = 0
    var miniGoals: [String] = []
    var taskType: TaskType = .cleaning
    
    var miniGoalString = ""
    var errorString = ""
    
    var showErrorAlert: Bool = false
    var showWarningAlert: Bool = false
    
    weak var modelContext: ModelContext?
    
    let hours: [Int] = [
        0, 1, 2
    ]
    
    let minutes: [Int] = [
        1, 2, 3, 4, 5, 7, 10, 15, 20, 25, 30, 45
    ]
    
    let emojiList: [String] = [
        "🧹",
        "📌",
        "🗑️",
        "💻",
        "⌨️",
        "🎧",
        "🔖",
        "📖",
        "🔥",
        "🧽",
        "🥣",
        "📧",
        "📝",
        "🧑‍💻",
        "👩‍💻",
        "📽️",
        "🛠️",
        "📱",
        "☎️",
        "🧘‍♂️",
        "🧘‍♀️",
        "🧘",
    ]
    
    func removeMinigoal(goal: String) {
        self.miniGoals.removeAll { $0 == goal }
    }
    
    func addMiniGoal() {
        if canAddMinigoal() {
            self.miniGoals.append(miniGoalString.cleaned())
            self.miniGoalString = ""
        }
    }
    
    private func canAddMinigoal() -> Bool {
        if miniGoalString.cleaned().isEmpty {
            self.errorString = "Cannot add empty item"
            self.showErrorAlert = true
            return false
        }
        
        if isDuplicate(string: miniGoalString) {
            self.errorString = "There is a duplicate item"
            self.showErrorAlert = true
            return false
        }
        
        return true
    }
    
    private func isDuplicate(string: String) -> Bool {
        self.miniGoals.contains(string.cleaned())
    }
    
    func dismissAlert() {
        self.showErrorAlert = false
        self.showWarningAlert = false
        self.errorString = ""
    }
    
    func deleteMiniGoal(indexSet: IndexSet) {
        for index in indexSet {
            self.miniGoals.remove(at: index)
        }
    }
    
    func makeTaskData() -> TaskData {
        let taskData = TaskData(title: self.title,
                                icon: self.icon,
                                durationMin: self.durationMin,
                                durationHr: self.durationHr,
                                miniGoals: self.miniGoals,
                                taskType: self.taskType)
        
        return taskData
    }
}
