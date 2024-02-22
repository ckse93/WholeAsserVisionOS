//
//  HomeView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import CloudKit
import SwiftUI
import SwiftData

let cardCornerRadius: CGFloat = 25

let presetData1: TaskData = .init(title: "3 minute power cleaning",
                                  icon: "🧹",
                                  durationMin: 3,
                                  durationHr: 0,
                                  miniGoals: [
                                        "organize desk",
                                        "empty trash can",
                                    ],
                                  taskType: .cleaning)

let presetData2: TaskData = .init(title: "45 minute work sprint",
                                  icon: "🔥",
                                  durationMin: 45,
                                  durationHr: 0,
                                  miniGoals: [],
                                  taskType: .work)

let presetData3: TaskData = .init(title: "10 minute misc work task",
                                  icon: "📎",
                                  durationMin: 10,
                                  durationHr: 0,
                                  miniGoals: [
                                        "do timesheet",
                                        "respond to emials",
                                  ],
                                  taskType: .work)
    
let presetData4: TaskData = .init(title: "15 min pull request",
                                  icon: "⌨️",
                                  durationMin: 15,
                                  durationHr: 0,
                                  miniGoals: [
                                    "check for commted out code",
                                        "double check documentation",
                                        "remove swear words",
                                    ],
                                  taskType: .work)

let presetData5: TaskData = .init(title: "Make reservation",
                                  icon: "📱",
                                  durationMin: 5,
                                  durationHr: 0,
                                  miniGoals: [
                                    "final check who's coming",
                                        "book a room",
                                        "keep it polite this time",
                                    ],
                                  taskType: .chores)

let presetData6: TaskData = .init(title: "Relax for a bit",
                                  icon: "🧘‍♀️",
                                  durationMin: 2,
                                  durationHr: 0,
                                  miniGoals: [
                                    "deep breath, feel air coming in and out",
                                    ],
                                  taskType: .misc)

struct HomeView: View {
    let sampleItems = [presetData1, 
                       presetData2,
                       presetData3,
                       presetData4,
                       presetData5,
                       presetData6
                    ]
    
    @State var showSheet: Bool = false
    @State var previewTask: TaskData?
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(TaskDataTransporter.self) var transporter
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack {
                    Text("Quick Items")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView {
                        ForEach(sampleItems) { sampleData in
                            Button {
                                self.transporter.taskData = sampleData
                                self.openWindow(id: WindowDestination.taskView.rawValue)
                            } label: {
                                TaskCardViewV2(taskData: sampleData)
                            }
                            .buttonStyle(CardButtonStyle2())
                            .clipShape(
                                RoundedRectangle(cornerRadius: 25.0)
                            )
                        }
                        
                    }
                }
                .frame(width: geo.size.width / 2)
                
                Divider()
                    .padding(.horizontal)
                
                SavedTaskView()
                    .frame(width: geo.size.width / 2)
            }
            
        }
        .padding()
        .sheet(item: $previewTask, content: { previewTaskData in
            VStack {
                HStack {
                    Button(action: {
                        self.previewTask = nil
                    }, label: {
                        Text("Dismiss")
                    })
                }
                .padding()
                
                Text(previewTaskData.icon)
            }
            
        })
    }
}

struct CardButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        // reuse the original button action
        Button(action: configuration.trigger, label: {
            configuration.label
                .padding()
                .background(.regularMaterial, in: .rect(cornerRadius: 12))
                .hoverEffect()
        })
        // This allows our button to retain
        // default system behavior like e.g.
        // the disabled gray out mask
        .buttonStyle(PlainButtonStyle())
    }
}

struct TaskCardView: View {
    let taskData: TaskData
    
    var body: some View {
        Button {
            
        } label: {
            VStack {
                ZStack(alignment: .bottomTrailing, content: {
                    Text(taskData.icon)
                        .font(.system(size: 60))
                        .padding()
                    
                    .overlay {
                        RoundedRectangle(cornerRadius: 12.0)
                            .stroke(Color.white, lineWidth: 2.0)
                    }
                    
                    Text("\(taskData.totalMinutes) min")
                        .font(.caption)
                        .padding(Spacing.x2)
                        .foregroundStyle(
                            .tertiary
                        )
                })
                
                Text(taskData.title)
                    .foregroundStyle(
                        .secondary
                    )
            }
            .padding()
            .background(
                .regularMaterial,
                in: .rect(cornerRadius: cardCornerRadius)
            )
        }
        .buttonStyle(.plain)
//        .buttonStyle(CardButtonStyle())
    }
}

#Preview {
    HomeView()
}
