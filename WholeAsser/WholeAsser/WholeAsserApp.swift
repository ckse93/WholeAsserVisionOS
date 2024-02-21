//
//  WholeAsserApp.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import CloudKit
import SwiftUI
import SwiftData

typealias TaskData = SchemaV1_0_0.TaskData

@Observable
final class TaskDataTransporter {
    var taskData: TaskData?
}

@main
struct WholeAsserApp: App {
    init() {
        let schema = Schema([
            TaskData.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            sharedModelContainer = try ModelContainer(for: schema,
                                                      migrationPlan: DataMigrationPlan.self,
                                                      configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    let sharedModelContainer: ModelContainer
    @State var transporter: TaskDataTransporter = .init()
    
    var body: some Scene {
        WindowGroup(id: WindowDestination.main.rawValue) {
            MainTabView()
                .frame(
                    minWidth: 800, maxWidth: 2000,
                    minHeight: 600, maxHeight: 1400)
                .environment(transporter)
        }
        .modelContainer(sharedModelContainer)
        
        WindowGroup(id: WindowDestination.taskView.rawValue) {
            TaskView()
                .environment(transporter)
        }
        .defaultSize(width: 400, height: 800)
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        
        WindowGroup(id: WindowDestination.taskTryItOutView.rawValue) {
            TaskView(isTryItOut: true)
                .environment(transporter)
        }
        .defaultSize(width: 400, height: 800)
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
    }
}

enum WindowDestination: String, Identifiable {
    var id: String {
        return String(describing: self)
    }
    case main = "mainView"
    case taskView = "taskView"
    case taskTryItOutView = "taskTryItOut"
    case MiniGoalSignView = "MiniGoalSignView"
}
