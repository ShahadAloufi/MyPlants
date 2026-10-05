import SwiftUI

/// Shown once every reminder for today has been checked off.
struct AllDoneView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            PlantMascotView(size: 160)
                .padding(.bottom, 26)

            Text("All Done! 🎉")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Theme.primaryText)

            Text("All Reminders Completed")
                .font(.system(size: 14))
                .foregroundStyle(Theme.secondaryText)
                .padding(.top, 6)

            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Theme.background.ignoresSafeArea()
        VStack(spacing: 0) {
            ScreenHeader()
            AllDoneView()
        }
    }
    .preferredColorScheme(.dark)
}
