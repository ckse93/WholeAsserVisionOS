//
//  asdasd.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/18/24.
//

import SwiftUI

struct asdasd: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(
                    Color.red
                )
                .frame(depth: 3.0)
                .shadow(radius: 10)
            
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(
                    Color.blue
                )
                .frame(depth: 55.0)
                .shadow(radius: 10)
        }
        .background {
            Color.green
        }
    }
}

#Preview {
    asdasd()
}
