import SwiftUI

struct AlarmRingingView: View {
    let alarmVM: AlarmViewModel
    @State private var pulseScale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                ringingIcon

                VStack(spacing: 8) {
                    Text(alarmVM.alarmState == .overshoot ? "You may have passed!" : "Wake Up!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Text(alarmVM.destinationName)
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.8))

                    Text(alarmVM.distanceDisplay)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("AccentOrange"))
                }

                Spacer()

                Button {
                    alarmVM.dismissAlarm()
                } label: {
                    Text("DISMISS ALARM")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(width: 240, height: 64)
                        .background(Color("AccentOrange"))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                }

                Spacer()
                    .frame(height: 60)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                pulseScale = 1.3
            }
        }
    }

    private var ringingIcon: some View {
        ZStack {
            Circle()
                .fill(Color("AccentOrange").opacity(0.2))
                .frame(width: 160, height: 160)
                .scaleEffect(pulseScale)

            Circle()
                .fill(Color("AccentOrange").opacity(0.4))
                .frame(width: 120, height: 120)
                .scaleEffect(pulseScale * 0.9)

            Image(systemName: alarmVM.alarmState == .overshoot ? "exclamationmark.triangle.fill" : "bell.fill")
                .font(.system(size: 56))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    AlarmRingingView(alarmVM: AlarmViewModel())
}
