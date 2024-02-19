//
//  TaskView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import Combine
import CloudKit
import SwiftUI
import SwiftData

let timerIntervalSecond: Double = 1.0

struct TaskView: View {
    init(vm: TaskViewModel) {
        self._vm = State(initialValue: vm)
        self.isPreview = false
        self.isTryItOut = false
    }
    
    init(vm: TaskViewModel, isPreview: Bool = false) {
        self._vm = State(initialValue: vm)
        self.isPreview = isPreview
        self.isTryItOut = false
    }
    
    init(vm: TaskViewModel, isTryItOut: Bool = false) {
        self._vm = State(initialValue: vm)
        self.isPreview = false
        self.isTryItOut = isTryItOut
    }
    
    let isPreview: Bool
    let isTryItOut: Bool
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    @Environment(\.modelContext) var modelContext
    
    @State var vm: TaskViewModel
    @State var title: String = ""
    
    @State var timeSpent: Double = 0.1
    @State var timer = Timer.publish(every: timerIntervalSecond,
                                     on: .main,
                                     in: .common).autoconnect()
    
    private func stopTimer() {
        timer.upstream.connect().cancel()
        vm.timerStatus = .done
        vm.showRatingView = true
    }
    
    func startTimer() {
        vm.timerStatus = .running
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func doneButtonAction() {
        stopTimer()
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()
            
            Gauge(
                value: timeSpent,
                in: vm.minimum...vm.taskDurationInSec,
                label: { Text("Label") },
                currentValueLabel: {
                    Text(vm.taskData.icon)
                        .font(.system(size: 70))
                        .padding()
                }
            )
            .gaugeStyle(TaskViewGaugeStyle())
            .padding()
            
            HStack {
                if !isPreview {
                    switch vm.timerStatus {
                    case .notStarted:
                        Button("Start") {
                            self.startTimer()
                        }
                    case .running:
                        EmptyView()
                    case .done:
                        Image(systemName: "checkmark")
                            .foregroundStyle(
                                Color.green
                            )
                    }
                }
            }
            .padding(.bottom)
            
            if !vm.taskData.miniGoals.isEmpty {
                VStack(alignment: .leading) {
                    Text("Mini goals")
                        .padding(.vertical)
                    
                    ScrollView {
                        ForEach(vm.taskData.miniGoals, id: \.self) { miniGoal in
                            MiniGoalButtonView(miniGoal: miniGoal)
                        }
                    }
                }
                .padding()
                .background(
                    .regularMaterial, in: .rect(cornerRadius: 20)
                )
            }
            
            Spacer()
        }
        .ornament(attachmentAnchor: .scene(.bottom), ornament: {
            HStack(spacing: Spacing.x4) {
                Group {
                    switch vm.timerStatus {
                    case .notStarted:
                        Button(action: {
                            vm.showWarningAlert = true
                        }, label: {
                            Text("Cancel")
                        })
                        .buttonStyle(CancelButtonStyle())
                    case .running:
                        Button(action: {
                            vm.showWarningAlert = true
                        }, label: {
                            Text("Cancel")
                        })
                        .buttonStyle(CancelButtonStyle())
                        
                        Button(action: {
                            self.doneButtonAction()
                        }, label: {
                            Text("Done")
                        })
                        .buttonStyle(SaveButtonStyle())
                    case .done:
                        Button(action: {
                            self.exitAction()
                        }, label: {
                            Text("Exit")
                        })
                        
                        if isTryItOut {
                            Button(action: {
                                let taskData = vm.taskData
                                modelContext.insert(taskData)
                                self.exitAction()
                            }, label: {
                                Text("Save task and Exit")
                            })
                        }
                    }
                }
            }
            .padding()
            .glassBackgroundEffect()
        })
        .onReceive(timer, perform: { _ in
            // this will call every "timerIntervalSecond" second has elapsed
            timeSpent += timerIntervalSecond
        })
        .onChange(of: timeSpent, { _, newValue in
            if newValue >= vm.taskDurationInSec {
                self.stopTimer()
            }
        })
        .padding()
        .animation(.easeIn, value: self.timeSpent)
        .animation(.easeIn, value: vm.timerStatus)
        .alert("Cancel and exit?",
               isPresented: $vm.showWarningAlert,
               actions: {
            Button(role: .cancel) {
                vm.showWarningAlert = false
            } label: {
                Text("Nah")
            }
            
            Button(role: .destructive) {
                self.openWindow(id: WindowDestination.main.rawValue)
            } label: {
                Text("Yes")
            }
        }, message: {
            Text("Do you want to cancel and exit?")
        })
        .sheet(isPresented: $vm.showRatingView, content: {
            VStack {
                Text("Done! How do you feel?")
                    .font(.title)
                    .padding()
                
                EmojiRatingView { rating in
                    vm.selectedRating = rating
                    vm.showRatingView = false
                }
            }
        })
        .onAppear(perform: {
            self.timer.upstream.connect().cancel()
            self.title = vm.taskData.title
            if !isPreview {
                self.dismissWindow(id: WindowDestination.main.rawValue)
            }
        })
        .onChange(of: vm.timerStatus, { _, newValue in
            switch newValue {
            case .done:
                self.title = vm.taskData.taskType.completionMessageArray.randomElement()!
            default:
                break
            }
        })
        .onDisappear(perform: {
            
        })
    }
    
    func exitAction() {
        vm.updatePostRating()
        print(vm.taskData.description)
        self.openWindow(id: WindowDestination.main.rawValue)
    }
}

struct MiniGoalButtonView: View {
    let miniGoal: String
    @State private var isDone: Bool = false
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    var body: some View {
        HStack {
            Button {
                self.isDone = true
            } label: {
                HStack {
                    if isDone {
                        Image(systemName: "checkmark")
                            .foregroundStyle(
                                Color.green
                            )
                    } else {
                        Image(systemName: "checkmark")
                            .foregroundStyle(
                                Color.gray
                            )
                    }
                    
                    Text(miniGoal)
                        .strikethrough(isDone, color: .green)
                }
                
            }
        }
    }
}

#Preview {
    TaskView(vm: .init(taskData: presetData1))
}

struct TaskViewGaugeStyle: GaugeStyle {
    private var gradient: Gradient = Gradient(colors: [.yellow, .green])
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            // back layer
            Circle()
                .foregroundStyle(
                    .regularMaterial
                )
//                .background(
//                    .regularMaterial
//                )
            
            Circle()
                .trim(from: 0.0, to: 0.75 * configuration.value)
//                .stroke(gradient, lineWidth: 20)
                .stroke(gradient, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(135))
            
            configuration.currentValueLabel
        }
    }
}
