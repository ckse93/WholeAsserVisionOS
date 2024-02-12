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
            MainView()
        }
        
        WindowGroup(id: WindowDestination.taskView.rawValue) {
            TaskView()
        }
        .defaultSize(width: 0.5, height: 0.5, depth: 0.0, in: .meters)
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
