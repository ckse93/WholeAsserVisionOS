//
//  EmojiRatingView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/14/24.
//

import SwiftUI

let ratingEmojis = ["😬", "😐", "🙂", "😊", "😎"]

struct EmojiRatingView: View {
    let exitAction: ((String) -> Void)
    
    var body: some View {
        HStack {
            ForEach(ratingEmojis, id: \.self) { element in
                Button(action: {
                    exitAction(element)
                }, label: {
                    Text(element)
                })
            }
        }
        .padding()
    }
}

#Preview {
    EmojiRatingView(exitAction: { _ in })
}
