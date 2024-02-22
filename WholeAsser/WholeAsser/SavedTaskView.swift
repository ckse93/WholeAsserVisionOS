//
//  SavedTaskView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/16/24.
//

import CloudKit
import Foundation
import SwiftData
import SwiftUI
import SFSymbolEnum

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
    @Environment(TaskDataTransporter.self) var transporter
    
    var body: some View {
        VStack {
            Text("Saved Items")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                ForEach(savedTaskData) { savedTaskData in
                    Button(action: {
                        self.transporter.taskData = savedTaskData
                        self.openWindow(id: WindowDestination.taskView.rawValue)
                    }, label: {
                        TaskCardViewV2(taskData: savedTaskData)
                    })
                    .buttonStyle(CardButtonStyle2())
                    .clipShape(
                        RoundedRectangle(cornerRadius: 25.0)
                    )
                }
//                LazyVGrid(columns: savedItemGrid,
//                          alignment: .center,
//                          spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/,
//                          pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
//                          content: {
//                    ForEach(savedTaskData) { savedTaskData in
//                        Button(action: {
//                            
//                        }, label: {
//                            TaskCardView(taskData: savedTaskData)
//                        })
//                        .buttonStyle(.plain)
////                        .simultaneousGesture(LongPressGesture(minimumDuration: 1.0).onEnded { _ in
////                            self.previewTask = savedTaskData
////                        })
//                        .simultaneousGesture(TapGesture().onEnded {
//                            self.openWindow(id: WindowDestination.taskView.rawValue,
//                                            value: savedTaskData)
//                        })
//                    }
//                })
                
                if !savedTaskData.isEmpty {
                    Button {
                        do {
                            try modelContext.delete(model: TaskData.self)
                        } catch {
                            
                        }
                    } label: {
                        Label("Delete All", systemImage: .trash)
                    }
                    .buttonStyle(CancelButtonStyle())
                }
            }
        }
    }
}

