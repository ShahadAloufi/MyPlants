import SwiftUI

/// First-run screen: no reminders yet.
struct StartJourneyView: View {
    var onStart: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            PlantMascotView(size: 170)
                .padding(.bottom, 28)

            Text("Start your plant journey!")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Theme.primaryText)

            Text("Now all your plants will be in one place and\nwe will help you take care of them 🪴")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundStyle(Theme.secondaryText)
                .padding(.top, 10)

            Button(action: onStart) {
                Text("Set Plant Reminder")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 13)
                    .background(Capsule().fill(Theme.mint))
            }
            .padding(.top, 26)

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
            StartJourneyView {}
        }
    }
    .preferredColorScheme(.dark)
}
