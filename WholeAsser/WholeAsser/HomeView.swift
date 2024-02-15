//
//  HomeView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftData
import SwiftUI

let presetData1: TaskData = .init(title: "3 minute power cleaning",
                                  icon: "🧹",
                                  durationMin: 3,
                                  durationHr: 0,
                                  miniGoals: [
                                        .init(title: "organize desk"),
                                        .init(title: "empty trash can")
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
                                        .init(title: "do timesheet"),
                                        .init(title: "respond to emials"),
                                  ],
                                  taskType: .work)
    
let presetData4: TaskData = .init(title: "15 min pull request",
                                  icon: "⌨️",
                                  durationMin: 15,
                                  durationHr: 0,
                                  miniGoals: [
                                    .init(title: "check for commted out code"),
                                        .init(title: "double check documentation"),
                                        .init(title: "remove swear words"),
                                    ],
                                  taskType: .work)

let presetData5: TaskData = .init(title: "Make reservation",
                                  icon: "📱",
                                  durationMin: 5,
                                  durationHr: 0,
                                  miniGoals: [
                                    .init(title: "final check who's coming"),
                                        .init(title: "book a room"),
                                        .init(title: "keep it polite this time"),
                                    ],
                                  taskType: .chores)

let presetData6: TaskData = .init(title: "Relax for a bit",
                                  icon: "🧘‍♀️",
                                  durationMin: 2,
                                  durationHr: 0,
                                  miniGoals: [
                                    .init(title: "deep breath, feel air coming in and out")
                                    ],
                                  taskType: .misc)

struct HomeView: View {
    
    private var quickItemGrid: [GridItem] = [
        GridItem(.flexible(minimum: 100), spacing: Spacing.x4, alignment: .top),
        GridItem(.flexible(minimum: 100), spacing: Spacing.x4, alignment: .top),
        GridItem(.flexible(minimum: 100), spacing: Spacing.x4, alignment: .top)
    ]
    
    
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
    
    var body: some View {
        HStack {
            VStack {
                Text("Quick Items")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                ScrollView {
                    LazyVGrid(columns: quickItemGrid,
                              alignment: .center,
                              spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/,
                              pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
                              content: {
                        ForEach(sampleItems) { sampleData in
                            Button(action: {
                                
                            }, label: {
                                TaskCardView(taskData: sampleData)
                            })
                            .buttonStyle(.plain)
                            .simultaneousGesture(LongPressGesture(minimumDuration: 1.0).onEnded { _ in
                                self.previewTask = sampleData
                            })
                            .simultaneousGesture(TapGesture().onEnded {
                                self.openWindow(id: WindowDestination.taskView.rawValue,
                                                value: sampleData)
                            })
                        }
                    })
                }
            }
            Divider()
            
            SavedTaskView()
        }
        .padding()
        .sheet(item: $previewTask, content: { previewTaskData in
            VStack {
                HStack {
                    Button(action: {
                        self.previewTask = nil
                    }, label: {
                        Text("Button")
                    })
                }
                .padding()
                
                Text(previewTaskData.icon)
            }
            
        })
    }
}

struct SavedTaskView: View {
    @Query var savedTaskData: [TaskData]
    @Environment(\.modelContext) var modelContext
    
    private var savedItemGrid: [GridItem] = [
        GridItem(.flexible(minimum: 100), spacing: Spacing.x4, alignment: .top),
        GridItem(.flexible(minimum: 100), spacing: Spacing.x4, alignment: .top),
        GridItem(.flexible(minimum: 100), spacing: Spacing.x4, alignment: .top)
    ]
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    var body: some View {
        VStack {
            Text("Saved Items")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView {
                LazyVGrid(columns: savedItemGrid,
                          alignment: .center,
                          spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/,
                          pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
                          content: {
                    ForEach(savedTaskData) { savedTaskData in
                        Button(action: {
                            
                        }, label: {
                            TaskCardView(taskData: savedTaskData)
                        })
                        .buttonStyle(.plain)
//                        .simultaneousGesture(LongPressGesture(minimumDuration: 1.0).onEnded { _ in
//                            self.previewTask = savedTaskData
//                        })
                        .simultaneousGesture(TapGesture().onEnded {
                            self.openWindow(id: WindowDestination.taskView.rawValue,
                                            value: savedTaskData)
                        })
                    }
                })
                
                Button {
                    do {
                        try modelContext.delete(model: TaskData.self)
                    } catch {
                        
                    }
                } label: {
                    Text("PURGE")
                }

            }
        }
    }
}

struct TaskCardView: View {
    let taskData: TaskData
    
    var body: some View {
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
            in: .rect(cornerRadius: 25)
        )
        .contentShape(.hoverEffect, .rect(cornerRadius: 15))
    }
}

#Preview {
    HomeView()
}
