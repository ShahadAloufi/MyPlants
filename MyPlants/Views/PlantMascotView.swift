import SwiftUI

/// The smiling succulent used on the welcome and "all done" screens.
struct PlantMascotView: View {
    var size: CGFloat = 170

    private let blades: [(angle: Double, height: Double, width: Double, tint: Color)] = [
        (-64, 0.74, 0.21, Theme.leafDark),
        (-36, 0.90, 0.23, Theme.leafLight),
        (-12, 1.00, 0.24, Theme.leafLight),
        (12, 0.97, 0.24, Theme.leafDark),
        (36, 0.88, 0.23, Theme.leafLight),
        (64, 0.72, 0.21, Theme.leafDark)
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            // Leaves fan out from the top of the pot.
            ZStack(alignment: .bottom) {
                ForEach(Array(blades.enumerated()), id: \.offset) { _, blade in
                    LeafShape()
                        .fill(blade.tint)
                        .frame(
                            width: size * blade.width,
                            height: size * 0.60 * blade.height
                        )
                        .rotationEffect(.degrees(blade.angle), anchor: .bottom)
                }
            }
            .frame(width: size, height: size * 0.60, alignment: .bottom)
            .offset(y: -size * 0.44)

            PotView(size: size)
        }
        .frame(width: size, height: size)
        .accessibilityLabel("A happy potted plant")
    }
}

private struct PotView: View {
    let size: CGFloat

    var body: some View {
        ZStack(alignment: .top) {
            PotBodyShape()
                .fill(
                    LinearGradient(
                        colors: [Theme.potLight, Theme.potDark],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: size * 0.62, height: size * 0.46)

            // Rim
            RoundedRectangle(cornerRadius: size * 0.035, style: .continuous)
                .fill(Theme.potLight)
                .frame(width: size * 0.70, height: size * 0.10)
                .offset(y: -size * 0.025)

            FaceView(size: size)
                .offset(y: size * 0.17)
        }
        .frame(width: size * 0.72, height: size * 0.48, alignment: .top)
    }
}

private struct FaceView: View {
    let size: CGFloat

    var body: some View {
        HStack(spacing: size * 0.075) {
            eye
            eye
        }
        .overlay(alignment: .bottom) {
            SmileShape()
                .stroke(Color.black.opacity(0.75), style: StrokeStyle(lineWidth: size * 0.016, lineCap: .round))
                .frame(width: size * 0.09, height: size * 0.035)
                .offset(y: size * 0.075)
        }
        .overlay(alignment: .leading) {
            cheek.offset(x: -size * 0.065, y: size * 0.03)
        }
        .overlay(alignment: .trailing) {
            cheek.offset(x: size * 0.065, y: size * 0.03)
        }
    }

    private var eye: some View {
        Capsule()
            .fill(Color.black.opacity(0.8))
            .frame(width: size * 0.028, height: size * 0.042)
    }

    private var cheek: some View {
        Circle()
            .fill(Theme.blush.opacity(0.55))
            .frame(width: size * 0.055, height: size * 0.055)
    }
}

// MARK: - Shapes

struct LeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.minY),
            control: CGPoint(x: rect.minX, y: rect.midY * 1.1)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control: CGPoint(x: rect.maxX, y: rect.midY * 1.1)
        )
        path.closeSubpath()
        return path
    }
}

struct PotBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        let inset = rect.width * 0.14
        let corner = rect.width * 0.14

        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - inset, y: rect.maxY - corner))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - inset - corner, y: rect.maxY),
            control: CGPoint(x: rect.maxX - inset, y: rect.maxY)
        )
        path.addLine(to: CGPoint(x: rect.minX + inset + corner, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + inset, y: rect.maxY - corner),
            control: CGPoint(x: rect.minX + inset, y: rect.maxY)
        )
        path.closeSubpath()
        return path
    }
}

struct SmileShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY),
            control: CGPoint(x: rect.midX, y: rect.maxY * 2)
        )
        return path
    }
}

#Preview {
    ZStack {
        Theme.background.ignoresSafeArea()
        PlantMascotView()
    }
}
