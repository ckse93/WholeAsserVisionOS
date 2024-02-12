//
//  ContentView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct MainView: View {
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Button("Start 1 min power cleaning") {
                self.openWindow(id: WindowDestination.taskView.rawValue)
                self.dismissWindow(id: WindowDestination.main.rawValue)
            }
        }
        .padding()
        .onAppear(perform: {
            self.dismissWindow(id: WindowDestination.taskView.rawValue)
        })
    }
}

#Preview(windowStyle: .automatic) {
    MainView()
}
