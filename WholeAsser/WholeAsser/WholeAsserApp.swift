//
//  WholeAsserApp.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftUI
import SwiftData

typealias TaskData = SchemaV1_0_0.TaskData

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
    
    var body: some Scene {
        WindowGroup(id: WindowDestination.main.rawValue) {
            MainTabView()
        }
        .defaultSize(width: 1, height: 1, depth: 0.0, in: .meters)
        .modelContainer(sharedModelContainer)
        
        WindowGroup(id: WindowDestination.taskView.rawValue, for: TaskData.self, content: { taskDataBinding in
            TaskView(vm: .init(taskData: taskDataBinding.wrappedValue!))
        })
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
