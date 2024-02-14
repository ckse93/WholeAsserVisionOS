//
//  Buttons.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SFSymbolEnum
import SwiftUI

struct ButtonSecondary: View {
    let action: (() -> Void)
    let title: String?
    let image: SFSymbol?
    let imageStr: String?
    let tintColor: [Color]
    let isFullWidth: Bool
    
    init(title: String? = nil,
         image: SFSymbol,
         tintColor: [Color] = defaultGradient,
         isFullWidth: Bool = false,
         action: @escaping () -> Void
    ) {
        self.action = action
        self.title = title
        self.image = image
        self.imageStr = nil
        self.tintColor = tintColor
        self.isFullWidth = isFullWidth
    }
    
    init(title: String? = nil,
         tintColor: [Color] = defaultGradient,
         isFullWidth: Bool = false,
         action: @escaping () -> Void
    ) {
        self.action = action
        self.title = title
        self.image = nil
        self.imageStr = nil
        self.tintColor = tintColor
        self.isFullWidth = isFullWidth
    }
    
    init(title: String? = nil,
         imageStr: String,
         tintColor: [Color] = defaultGradient,
         isFullWidth: Bool = false,
         action: @escaping () -> Void
    ) {
        self.action = action
        self.title = title
        self.image = nil
        self.imageStr = imageStr
        self.tintColor = tintColor
        self.isFullWidth = isFullWidth
    }
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            HStack {
                if isFullWidth {
                    Spacer()
                }
                
                if let imageStr = imageStr {
                    Image(imageStr)
                } else if let image = image {
                    Image(systemName: image)
                }
                
                if let title = title {
                    Text(title)
                }
                
                if isFullWidth {
                    Spacer()
                }
                    
            }
        })
        .buttonStyle(SecondaryButtonStyle(gradient: tintColor))
        
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    let gradient: [Color]
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
//            .background(
//                LinearGradient(colors: gradient,
//                               startPoint: .topLeading,
//                               endPoint: .bottomTrailing)
//            )
            .overlay(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(LinearGradient(colors: gradient,
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing), lineWidth: 5)
            )
            .tint(.white)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .contentShape(
                RoundedRectangle(cornerRadius: 25.0)
            )
            .hoverEffect()
    }
}

struct ButtonPrimary: View {
    let action: (() -> Void)
    let title: String?
    let image: SFSymbol?
    let imageStr: String?
    let backgroundGradient: [Color]
    let isFullWidth: Bool
    
    init(title: String? = nil,
         image: SFSymbol,
         backgroundColor: [Color] = defaultGradient,
         isFullWidth: Bool = false,
         action: @escaping () -> Void
    ) {
        self.action = action
        self.title = title
        self.image = image
        self.imageStr = nil
        self.backgroundGradient = backgroundColor
        self.isFullWidth = isFullWidth
    }
    
    init(title: String? = nil,
         backgroundColor: [Color] = defaultGradient,
         isFullWidth: Bool = false,
         action: @escaping () -> Void
    ) {
        self.action = action
        self.title = title
        self.image = nil
        self.imageStr = nil
        self.backgroundGradient = defaultGradient
        self.isFullWidth = isFullWidth
    }
    
    init(title: String? = nil,
         imageStr: String,
         backgroundColor: [Color] = defaultGradient,
         isFullWidth: Bool = false,
         action: @escaping () -> Void
    ) {
        self.action = action
        self.title = title
        self.image = nil
        self.imageStr = imageStr
        self.backgroundGradient = backgroundColor
        self.isFullWidth = isFullWidth
    }
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            HStack {
                if isFullWidth {
                    Spacer()
                }
                
                if let imageStr = imageStr {
                    Image(imageStr)
                } else if let image = image {
                    Image(systemName: image)
                }
                
                if let title = title {
                    Text(title)
                }
                
                if isFullWidth {
                    Spacer()
                }
            }
        })
        .buttonStyle(PrimaryButtonStyle(gradient: backgroundGradient))
    }
}

#Preview {
    VStack {
        ButtonSecondary(title: "Test Button", image: .play, action: {})
        ButtonPrimary(title: "Test 2", image: .mic, isFullWidth: true, action: {})
    }
}

fileprivate let defaultGradient: [Color] = [.assGradientStart, .assGradientEnd]

struct PrimaryButtonStyle: ButtonStyle {
    let gradient: [Color]
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                LinearGradient(colors: gradient,
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 15.0)
            )
            .tint(.white)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .contentShape(
                RoundedRectangle(cornerRadius: 15.0)
            )
            .hoverEffect()
    }
}
