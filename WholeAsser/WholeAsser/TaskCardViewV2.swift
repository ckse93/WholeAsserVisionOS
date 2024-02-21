//
//  TaskCardViewV2.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/18/24.
//

import SwiftUI

struct TaskCardViewV2: View {
    let taskData: TaskData
    var body: some View {
        HStack(alignment: .top, content: {
            ZStack {
                Text(taskData.icon)
                    .font(.system(size: 45))
                    .padding(Spacing.x5)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
            }
            .background(
                taskData.taskType.colorPackage.base.main
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .padding()
            
            VStack(alignment: .leading, content: {
                HStack(alignment: .top, content: {
                    Text(taskData.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.trailing)
                    
                    Spacer()
                    
                    Text(taskData.taskType.rawValue)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            taskData.taskType.colorPackage.complimentary.popDark
                        )
                        .padding(.horizontal)
                        .padding(2)
                        .background(
                            taskData.taskType.colorPackage.complimentary.popPale
                        )
                        .clipShape(Capsule())
                })
                .padding([.top, .trailing])
                
                Divider()
                
                Text("\(taskData.totalMinutes) min")
                    .font(.caption)
                    .padding(.top, Spacing.x1)
                    .foregroundStyle(
                        .tertiary
                    )
                
                if !taskData.miniGoals.isEmpty {
                    Text("\(taskData.miniGoals.count) mini goal(s)")
                        .font(.caption)
                        .padding(.top, Spacing.x1)
                        .foregroundStyle(
                            .tertiary
                        )
                }
            })
        })
        .padding(4)
        .background(
            .regularMaterial
        )
    }
}
struct CardButtonStyle2: PrimitiveButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        // reuse the original button action
        Button(action: configuration.trigger, label: {
            configuration.label
                .background(.regularMaterial, in: .rect(cornerRadius: 25))
                .hoverEffect()
        })
        // This allows our button to retain
        // default system behavior like e.g.
        // the disabled gray out mask
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 10) {
            Button(action: {
                
            }, label: {
                TaskCardViewV2(taskData: presetData5)
            })
            .buttonStyle(CardButtonStyle())
            .clipShape(
                RoundedRectangle(cornerRadius: 25.0)
            )
            
            TaskCardViewV2(taskData: presetData5)
            
            TaskCardViewV2(taskData: presetData6)
            
            TaskCardViewV2(taskData: presetData1)
            
            TaskCardViewV2(taskData: presetData2)
            
            TaskCardViewV2(taskData: presetData3)
            
            TaskCardViewV2(taskData: presetData4)
        }
        .padding()
    }
    
}
