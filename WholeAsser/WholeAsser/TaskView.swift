//
//  TaskView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    @State var vm: TaskViewModel = .init()
    
    @State var title: String = "1 min power cleaning"
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title)
                
                switch vm.timerStatus {
                case .notStarted:
                    Button("Start") {
                        vm.startTimer()
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
            
            Gauge(value: vm.timeSpent, in: vm.min...vm.taskDuration) {
                Text("")
            }
            .gaugeStyle(.accessoryLinearCapacity)
            .tint(
                Gradient(colors: [.yellow, .green])
            )
//            .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text("Mini goals")
            }
            ForEach(vm.miniGoals) { miniGoal in
                MiniGoalButtonView(vm: miniGoal)
            }
            
            Button(action: {
                self.openWindow(id: WindowDestination.main.rawValue)
            }, label: {
                Text("Cancel")
            })
            
        }
        .padding()
        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: vm.timeSpent)
        .onAppear(perform: {
            self.dismissWindow(id: WindowDestination.main.rawValue)
        })
        .onChange(of: vm.timerStatus, { _, newValue in
            switch newValue {
            case .done:
                self.title = doneMessages.randomElement()!
            default:
                break
            }
        })
        .onDisappear(perform: {
            
        })
    }
}

struct MiniGoalButtonView: View {
    @Bindable var vm: TaskViewModel.MiniGoalViewModel
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    var body: some View {
        HStack {
            Button {
                vm.isDone = true
            } label: {
                HStack {
                    if vm.isDone {
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
                    
                    Text(vm.title)
                        .strikethrough(vm.isDone, color: .green)
                }
                
            }
            
//            Spacer()
//            
//            Button(action: {
////                Op
//            }, label: {
//                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//            })
        }
    }
}

#Preview {
    TaskView()
}

let doneMessages:[String] = [
    "Done! good job! 👏",
    "Done! you should be proud of yourself 👍",
    "Done! nice acheivement! 🏆",
    "Done! that was easy, wasn't it? 😎",
    "Done! let's do it again soon ✨",
    "Done! looks a LOT better now ✨",
    "Nice!, Look at this, you did it! ✨",
    "You did it! It looks amazing now! 😍",
    "You did it!, let's make this a habit? 😜",
    "Yeah this looks WAY better now 👏",
    "It really wasn't that hard, but look at this! Awesome! 🥳"
]
