//
//  MiniGoalSignView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftUI

struct MiniGoalSignView: View {
    let action: (() -> Void)
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Button(action: {
                self.action()
            }, label: {
                Text("Done")
            })
        }
        .ornament(attachmentAnchor: .scene(.top)) {
            Text("⭐️")
                .font(.system(size: 30))
                .padding(30)
                .glassBackgroundEffect()
        }
    }
}

#Preview {
    MiniGoalSignView(action: {}, title: "Empty Trash")
}
