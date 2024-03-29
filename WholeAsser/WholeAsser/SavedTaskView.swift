//
//  SavedTaskView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/16/24.
//

import Foundation
import SwiftData
import SwiftUI

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

