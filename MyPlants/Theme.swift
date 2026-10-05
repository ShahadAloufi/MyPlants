import SwiftUI

/// Central palette + reusable chrome for the app's dark "plant care" look.
enum Theme {
    static let background = Color.black
    static let card = Color(red: 0.11, green: 0.11, blue: 0.12)
    static let cardRaised = Color(red: 0.16, green: 0.16, blue: 0.17)
    static let sheetBackground = Color(red: 0.07, green: 0.07, blue: 0.08)

    static let mint = Color(red: 0.60, green: 0.90, blue: 0.74)
    static let mintDeep = Color(red: 0.33, green: 0.80, blue: 0.56)

    static let primaryText = Color.white
    static let secondaryText = Color(white: 0.60)
    static let mutedText = Color(white: 0.42)
    static let separator = Color(white: 0.20)
    static let danger = Color(red: 0.98, green: 0.27, blue: 0.27)

    static let sunYellow = Color(red: 0.95, green: 0.82, blue: 0.47)
    static let waterBlue = Color(red: 0.52, green: 0.78, blue: 0.95)

    static let potLight = Color(red: 0.95, green: 0.69, blue: 0.59)
    static let potDark = Color(red: 0.89, green: 0.58, blue: 0.48)
    static let leafLight = Color(red: 0.49, green: 0.87, blue: 0.69)
    static let leafDark = Color(red: 0.24, green: 0.69, blue: 0.51)
    static let blush = Color(red: 0.96, green: 0.52, blue: 0.48)
}

/// The "My Plants 🌱" title bar used on every main screen.
struct ScreenHeader<Trailing: View>: View {
    var title: String = "My Plants"
    @ViewBuilder var trailing: Trailing

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(title) 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Theme.primaryText)
                Spacer()
                trailing
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)

            Rectangle()
                .fill(Theme.separator)
                .frame(height: 0.6)
        }
    }
}

extension ScreenHeader where Trailing == EmptyView {
    init(title: String = "My Plants") {
        self.init(title: title) { EmptyView() }
    }
}

/// Small rounded capsule used for the "Full sun" / "20-50 ml" chips on a row.
struct InfoChip: View {
    let symbol: String
    let text: String
    let tint: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: symbol)
                .font(.system(size: 10, weight: .semibold))
            Text(text)
                .font(.system(size: 12, weight: .medium))
        }
        .foregroundStyle(tint)
        .padding(.horizontal, 9)
        .padding(.vertical, 5)
        .background(
            Capsule().fill(Theme.cardRaised)
        )
    }
}
