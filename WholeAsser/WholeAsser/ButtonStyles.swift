//
//  ButtonStyles.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/16/24.
//

import Foundation
import SwiftUI

struct CircleBtnStyle: PrimitiveButtonStyle {
    let color: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: configuration.trigger, label: {
            configuration.label
                .padding(Spacing.x3)
                .foregroundStyle(Color.white)
                .background(
                    color
                )
                .clipShape(Circle())
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct DefaultBtnStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: configuration.trigger, label: {
            configuration.label
                .padding(Spacing.x3)
                .padding(.horizontal, Spacing.x1)
                .foregroundStyle(Color.white)
                .clipShape(Capsule())
        })
        .buttonStyle(DefaultButtonStyle())
    }
}

struct CancelButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: configuration.trigger, label: {
            configuration.label
                .padding(Spacing.x3)
                .padding(.horizontal, Spacing.x1)
                .foregroundStyle(Color.white)
                .background(Color.systemRed)
                .clipShape(Capsule())
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct SaveButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        // reuse the original button action
        Button(action: configuration.trigger, label: {
            // configure the button label to our needs
            configuration.label
                .padding(Spacing.x3)
                .padding(.horizontal, Spacing.x1)
                .foregroundStyle(Color.white)
                .background(Color.systemGreen)
                .clipShape(Capsule())
        })
        // This allows our button to retain
        // default system behavior like e.g.
        // the disabled gray out mask
        .buttonStyle(PlainButtonStyle())
    }
}
