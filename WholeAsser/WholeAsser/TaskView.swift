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
import SFSymbolEnum

let timerIntervalSecond: Double = 1.0

struct TaskView: View {
    init() {
        self.isPreview = false
        self.isTryItOut = false
    }
    
    init(isPreview: Bool = false) {
        self.isPreview = isPreview
        self.isTryItOut = false
    }
    
    init(isTryItOut: Bool = false) {
        self.isPreview = false
        self.isTryItOut = isTryItOut
    }
    
    let isPreview: Bool
    let isTryItOut: Bool
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    @Environment(\.modelContext) var modelContext
    @Environment(TaskDataTransporter.self) var tranporter
    
    @State var vm: TaskViewModel = .init()
    
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
            switch vm.fetchStatus {
            case .loading:
                ProgressView()
                    .controlSize(.extraLarge)
            case .success(let taskData):
                Text(taskData.title)
                    .lineLimit(3)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                ZStack(alignment: .topTrailing) {
                    Gauge(
                        value: timeSpent,
                        in: vm.minimum...taskData.taskDurationInSec,
                        label: { Text("Label") },
                        currentValueLabel: {
                            Text(taskData.icon)
                                .font(.system(size: 70))
                                .padding()
                        }
                    )
                    .gaugeStyle(TaskViewGaugeStyle(gradient: .init(colors: [taskData.taskType.colorPackage.base.accentPale,
                                                                            taskData.taskType.colorPackage.base.accentDark])))
                    .padding()
                    
                    if let rating = vm.selectedRating {
                        Text(rating)
                            .font(.system(size: 40))
                            .animation(.spring(duration: 1, bounce: 0.9), value: vm.selectedRating)
                    } else {
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
                    }
                }
                
                HStack {
                    if !isPreview {
                        switch vm.timerStatus {
                        case .notStarted:
                            Button("Start") {
                                self.startTimer()
                            }
                        case .running:
                            Text(" ")
                        case .done:
                            Text("🎉 Done! good job!")
                        }
                    }
                }
                .padding(.bottom)
                
                if !taskData.miniGoals.isEmpty {
                    VStack(alignment: .leading) {
                        List {
                            Section {
                                ForEach(taskData.miniGoals, id: \.self) { miniGoal in
                                    MiniGoalButtonView(miniGoal: miniGoal)
                                }
                            } header: {
                                Text("Mini goals")
                                    .padding(.vertical)
                            }
                        }
                    }
                    .padding()
                    .background(
                        .regularMaterial, in: .rect(cornerRadius: 20)
                    )
                }
                
                Spacer()
            case .failed:
                Text("⚠️")
                    .font(.system(size: 40))
                Text("There was an error, please try again later")
            }
        }
        .ornament(attachmentAnchor: .scene(.bottom), ornament: {
            HStack(spacing: Spacing.x4) {
                Group {
                    switch vm.timerStatus {
                    case .notStarted:
                        Button(action: {
                            vm.showWarningAlert = true
                        }, label: {
                            Label("Cancel", systemImage: .multiply)
                        })
                        .buttonStyle(CancelButtonStyle())
                    case .running:
                        Button(action: {
                            vm.showWarningAlert = true
                        }, label: {
                            Label("Cancel", systemImage: .multiply)
                        })
                        .buttonStyle(CancelButtonStyle())
                        
                        Button(action: {
                            self.doneButtonAction()
                        }, label: {
                            Label("Done", systemImage: .checkmark)
                        })
                        .buttonStyle(SaveButtonStyle())
                    case .done:
                        Button(action: {
                            self.exitAction()
                        }, label: {
                            Label("Exit", systemImage: .multiply)
                        })
                        
                        if isTryItOut && vm.taskData != nil {
                            Button(action: {
                                let taskData = vm.taskData!
                                modelContext.insert(taskData)
                                self.exitAction()
                            }, label: {
                                Label("Save task and exit", systemImage: .checkmark)
                            })
                        }
                    }
                }
            }
            .padding()
            .glassBackgroundEffect()
        })
        .onAppear {
            vm.reset()
            self.timer.upstream.connect().cancel()
            if !isPreview {
                self.dismissWindow(id: WindowDestination.main.rawValue)
            }
            if let data = tranporter.taskData {
                vm.taskData = data
                vm.fetchStatus = .success(data)
            } else {
                vm.fetchStatus = .failed
            }
        }
        .onReceive(timer, perform: { _ in
            // this will call every "timerIntervalSecond" second has elapsed
            timeSpent += timerIntervalSecond
        })
        .onChange(of: timeSpent, { _, newValue in
            if let taskData = vm.taskData {
                if newValue >= taskData.taskDurationInSec {
                    self.stopTimer()
                }
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
        .onChange(of: vm.timerStatus, { _, newValue in
            switch newValue {
            case .done:
                break
//                self.title = vm.taskData.taskType.completionMessageArray.randomElement()!
            default:
                break
            }
        })
        .onDisappear(perform: {
            
        })
    }
    
    func exitAction() {
        if let taskData = vm.taskData,
           let rating = vm.selectedRating
        {
            taskData.postTaskRatings.append(rating)
            print(vm.taskData?.description as Any)
        }
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
struct TaskViewGaugeStyle: GaugeStyle {
    let gradient: Gradient
    
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
