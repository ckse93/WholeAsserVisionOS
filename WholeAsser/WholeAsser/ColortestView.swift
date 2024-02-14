//
//  ColortestView.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import SwiftUI

struct CC {
    let name: String
    let color: Color

    static var colors: [CC] { [
        CC(name: "lightText", color: .lightText),
        CC(name: "darkText", color: .darkText),
        CC(name: "placeholderText", color: .placeholderText),
        CC(name: "label", color: .label),
        CC(name: "secondaryLabel", color: .secondaryLabel),
        CC(name: "tertiaryLabel", color: .tertiaryLabel),
        CC(name: "quaternaryLabel", color: .quaternaryLabel),
        CC(name: "systemBackground", color: .systemBackground),
        CC(name: "secondarySystemBackground", color: .secondarySystemBackground),
        CC(name: "tertiarySystemBackground", color: .tertiarySystemBackground),
        CC(name: "systemFill", color: .systemFill),
        CC(name: "secondarySystemFill", color: .secondarySystemFill),
        CC(name: "tertiarySystemFill", color: .tertiarySystemFill),
        CC(name: "quaternarySystemFill", color: .quaternarySystemFill),
        CC(name: "systemGroupedBackground", color: .systemGroupedBackground),
        CC(name: "secondarySystemGroupedBackground", color: .secondarySystemGroupedBackground),
        CC(name: "tertiarySystemGroupedBackground", color: .tertiarySystemGroupedBackground),
        CC(name: "systemGray", color: .systemGray),
        CC(name: "systemGray2", color: .systemGray2),
        CC(name: "systemGray3", color: .systemGray3),
        CC(name: "systemGray4", color: .systemGray4),
        CC(name: "systemGray5", color: .systemGray5),
        CC(name: "systemGray6", color: .systemGray6),
        CC(name: "separator", color: .separator),
        CC(name: "opaqueSeparator", color: .opaqueSeparator),
        CC(name: "link", color: .link),
        CC(name: "systemRed", color: .systemRed),
        CC(name: "systemBlue", color: .systemBlue),
        CC(name: "systemPink", color: .systemPink),
        CC(name: "systemTeal", color: .systemTeal),
        CC(name: "systemGreen", color: .systemGreen),
        CC(name: "systemIndigo", color: .systemIndigo),
        CC(name: "systemOrange", color: .systemOrange),
        CC(name: "systemPurple", color: .systemPurple),
        CC(name: "systemYellow", color: .systemYellow)]
    }
}

struct ColorTestView: View {
    @State var backgroundColor: Color = .systemBackground
    @State var forceDark: Bool = false
    @State var showLine: Bool = true
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .trailing) {
                Picker("Change background",
                       selection: $backgroundColor) {
                    Text("systemBackground")
                        .tag(Color.systemBackground)
                    Text("secondarySystemBackground")
                        .tag(Color.secondarySystemBackground)
                    Text("tertiarySystemBackground")
                        .tag(Color.tertiarySystemBackground)
                    Text("systemGroupedBackground")
                        .tag(Color.systemGroupedBackground)
                    Text("secondarySystemGroupedBackground")
                        .tag(Color.secondarySystemGroupedBackground)
                    Text("tertiarySystemGroupedBackground")
                        .tag(Color.tertiarySystemGroupedBackground)
                }
                Toggle(isOn: $forceDark, label: {
                    Text("dark mode")
                })
                Toggle(isOn: $showLine, label: {
                    Text("show border")
                })
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack {
                Spacer()
                Text("Light")
                    .frame(width: 75, height: 40)
                Text("Dark")
                    .frame(width: 75, height: 40)
            }
            .padding()
            
            ScrollView {
                ForEach(CC.colors, id: \.name) { color in
                    HStack {
                        Text(color.name)
                        Spacer()
                        Group {
                            Rectangle()
                                .environment(\.colorScheme, .light)
                            Rectangle()
                                .environment(\.colorScheme, .dark)
                        }
                        .frame(width: 75, height: 40)
                        .foregroundColor(color.color)
                        .border(showLine ? Color.label: Color.clear, width: 1)

                    }
                }
            }
            .padding(.horizontal)
        }
        .background(
            backgroundColor
        )
        .preferredColorScheme(forceDark ? .dark : .light)
        .navigationTitle("Places")
    }
}

#Preview {
    ColorTestView()
}
