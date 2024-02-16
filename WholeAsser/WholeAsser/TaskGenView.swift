//
//  TaskGenView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftUI

struct TaskGenView: View {
    @Environment(\.modelContext) var modelContext
    @State var vm: TaskGenViewModel = .init()
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    let cancelAction: (() -> Void)
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Create Task")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    ZStack(alignment: .bottomTrailing, content: {
                        Text(vm.icon)
                            .font(.system(size: 150))
                            .padding(Spacing.x10)
                            .background(
                                .thinMaterial
                            )
                            .clipShape(
                                Circle()
                            )
                            .padding(.bottom)
                        
                        Picker(selection: $vm.icon) {
                            ForEach(vm.emojiList, id: \.self) { emoji in
                                Text(emoji)
                                    .font(.title)
                            }
                        } label: {
                            Image(systemName: .arrowUp)
                        }
                        .offset(x: 30)
                    })
                    .padding()
                    
                    HStack {
                        TextField("task title", text: $vm.title, prompt: Text("task title"))
                            .padding()
                            .background(
                                
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 25.0)
                            )
                            .shadow(radius: 5)
                        
                        if !vm.title.isEmpty {
                            Button(action: {
                                vm.title = ""
                            }, label: {
                                Image(systemName: "multiply")
                            })
                            .background(
                                .thinMaterial
                            )
                            .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Picker(selection: $vm.taskType, label: Label(
                            title: { Text("Task type") },
                            icon: { Image(systemName: "42.circle") }
                        )) {
                            ForEach(TaskType.allCases, id: \.self) { taskType in
                                Text(taskType.rawValue)
                                    .tag(taskType)
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Picker("Hour", selection: $vm.durationHr) {
                            ForEach(vm.hours, id: \.self) { hr in
                                Text("\(hr) hr")
                                    .tag(hr)
                            }
                        }
                        
                        Picker("Minute", selection: $vm.durationMin) {
                            ForEach(vm.minutes, id: \.self) { minute in
                                Text("\(minute) mins")
                                    .tag(minute)
                            }
                        }
                        .padding()
                    }
                    
                }
                
                Divider()
                
                VStack {
                    
                    Text("Mini goals")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    HStack {
                        Button(action: {
                            vm.addMiniGoal()
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .background(
                            Color.green
                        )
                        .clipShape(Circle())
                        
                        TextField("task title", text: $vm.miniGoalString, prompt: Text("mini goal"))
                            .padding()
                            .background(
                                
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 25.0)
                            )
                        
                        if !vm.miniGoalString.isEmpty {
                            Button(action: {
                                vm.miniGoalString = ""
                            }, label: {
                                Image(systemName: "multiply")
                            })
                            .clipShape(Circle())
                        }
                    }
                    .padding(.bottom)
                    List {
                        ForEach(vm.miniGoals, id: \.self) { minigoal in
                            HStack {
                                Text(minigoal)
                                Spacer()
                                Image(systemName: .textJustify)
                            }
                            .hoverEffect()
                        }
                        .onMove(perform: { from, to in
                            vm.miniGoals.move(fromOffsets: from, toOffset: to)
                        })
                        .onDelete(perform: { indexSet in
                            vm.deleteMiniGoal(indexSet: indexSet)
                        })
                    }
                    .frame(idealHeight: 250)
                }
                .padding()
            }
        }
        .padding()
        .glassBackgroundEffect()
        .onAppear(perform: {
            vm.modelContext = self.modelContext
        })
        .alert("Error",
               isPresented: $vm.showErrorAlert) {
            Button("Close", role: .cancel) {
                vm.dismissAlert()
            }
        } message: {
            Text(vm.errorString)
        }
        .alert("Exit?",
               isPresented: $vm.showWarningAlert, actions: {
            Button(role: .cancel) {
                vm.dismissAlert()
            } label: {
                Text("Nah")
            }
            
            Button(role: .destructive) {
                self.cancelAction()
            } label: {
                Text("Yes")
            }

        }, message: {
            Text("Do you really want to exit?")
        })
        .animation(.easeIn, value: vm.miniGoalString)
        .ornament(attachmentAnchor: .scene(.bottom)) {
            HStack {
                Button("Cancel") {
                    vm.showWarningAlert = true
                }
                
                Button("Save") {
                    let taskData = vm.makeTaskData()
                    modelContext.insert(taskData)
                    self.cancelAction()
                }
                
                Button("Try it out") {
                    self.openWindow(id: WindowDestination.taskTryItOutView.rawValue,
                                    value: vm.makeTaskData())
                }
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
}

#Preview {
    TaskGenView(cancelAction: {})
}

extension Int {
    func secondsToHoursMinutesSeconds() -> (Int, Int, Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
    
    func minutesToHoursMinutes() -> (Int, Int) {
        return (self / 3600, (self % 3600) / 60)
    }
}
