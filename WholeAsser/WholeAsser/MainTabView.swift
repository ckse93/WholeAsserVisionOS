//
//  ContentView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftUI
import SFSymbolEnum
import RealityKit
import RealityKitContent

enum TabItem: CaseIterable, Identifiable {
    case main
    case taskGen
    
    var name: String {
        switch self {
        case .main:
            return "Home"
        case .taskGen:
            return "Create task"
        }
    }
    
    var image: SFSymbol {
        switch self {
        case .main:
            return .house
        case .taskGen:
            return .pencilAndOutline
        }
    }
    
    var id: String {
        self.name
    }
}


struct MainTabView: View {
    @State private var selectedTab: TabItem = .main
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
            ForEach(TabItem.allCases) { tabItem in
                switch tabItem {
                case .main:
//                    VStack {
//                        Button("Start 1 min power cleaning") {
//                            self.openWindow(id: WindowDestination.taskView.rawValue)
//                            self.dismissWindow(id: WindowDestination.main.rawValue)
//                        }
//                    }
//                    .padding()
                    HomeView()
                    .onAppear(perform: {
                        self.dismissWindow(id: WindowDestination.taskView.rawValue)
                    })
                    .tabItem {
                        Label(tabItem.name, systemImage: tabItem.image.rawValue)
                    }
                    .tag(TabItem.main)
                    
                case .taskGen:
                    TaskGenView(cancelAction: {
                        selectedTab = .main
                    })
                        .tabItem {
                            Label(tabItem.name, systemImage: tabItem.image.rawValue)
                        }
                        .tag(TabItem.taskGen)
                }
            }
        })
        

    }
}

#Preview(windowStyle: .automatic) {
    MainTabView()
}
