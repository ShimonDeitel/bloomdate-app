import SwiftUI

/// peony pink on deep plum
enum Theme {
    static let accent = Color(red: 0.7098, green: 0.3373, blue: 0.5490)
    static let accentSecondary = Color(red: 0.2392, green: 0.1686, blue: 0.2275)
    static let background = Color(red: 0.1137, green: 0.0784, blue: 0.1020)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
