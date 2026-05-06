import AVFoundation
import UIKit

final class AlarmPlayer {
    static let shared = AlarmPlayer()
    private var audioPlayer: AVAudioPlayer?

    private init() {}

    func playAlarm(soundName: String = "alarm") {
        guard UIApplication.shared.applicationState == .active else {
            return
        }

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, options: .mixWithOthers)
            try session.setActive(true)

            if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = 1.0
                audioPlayer?.play()
            } else {
                try session.setCategory(.playback)
                try session.setActive(true)
                AudioServicesPlaySystemSound(SystemSoundID(4095))
            }
        } catch {
            print("Audio session error: \(error)")
        }
    }

    func stopAlarm() {
        audioPlayer?.stop()
        audioPlayer = nil
        try? AVAudioSession.sharedInstance().setActive(false)
    }

    var isPlaying: Bool {
        audioPlayer?.isPlaying ?? false
    }
}
