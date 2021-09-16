import Foundation
import SwiftUI

struct RoundedButton: View {
    enum Style: Equatable {
        case primary
        case secondary
    }
    
    let title: String
    var action: () -> Void
    let style: Style
    
    var body: some View {
        #if os(iOS)
        ios
        #elseif os(macOS)
        standard
        #elseif os(watchOS)
        standard
        #elseif os(tvOS)
        standard
        #else
        standard
        #endif
    }

    var standard: some View {
        Button(title) {
            action()
        }
    }
    
    var ios: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(title).font(.headline)
                Spacer()
            }
            .foregroundColor(style == .primary ? .white : .black)
            .padding()
            .background(style == .primary ? Color("AccentColor") : Color.init(red: 0.8, green: 0.8, blue: 0.8))
            .cornerRadius(15.0)
            .frame(maxWidth: 300, minHeight: 50)
        })
    }
    
    init(
        _ title: String,
        style: Style = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}
