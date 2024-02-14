//
//  WholeAsserApp.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftUI

@main
struct WholeAsserApp: App {
    var body: some Scene {
        WindowGroup(id: WindowDestination.main.rawValue) {
            MainTabView()
        }
        .defaultSize(width: 1, height: 1, depth: 0.0, in: .meters)
        
        WindowGroup(id: WindowDestination.taskView.rawValue, for: TaskData.self, content: { taskDataBinding in
            TaskView(vm: .init(taskData: taskDataBinding.wrappedValue!))
        })
//        .defaultSize(width: 0.5, height: 0.5, depth: 0.0, in: .meters)
        .defaultSize(width: 400, height: 800)
        .windowResizability(.contentSize)
    }
}

enum WindowDestination: String, Identifiable {
    var id: String {
        return String(describing: self)
    }
    case main = "mainView"
    case taskView = "taskView"
    case MiniGoalSignView = "MiniGoalSignView"
}
