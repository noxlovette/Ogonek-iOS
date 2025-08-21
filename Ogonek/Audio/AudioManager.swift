import AVFoundation
import SwiftUI

@Observable
class AudioManager {
    static let shared = AudioManager()

    private var audioPlayer: AVAudioPlayer?

    private init() {
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }

    func playSound(named fileName: String, fileType: String = "mp3") {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("❌ Audio file not found: \(fileName).\(fileType)")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            print("🔊 Playing: \(fileName).\(fileType)")
        } catch {
            print("❌ Error playing audio: \(error)")
        }
    }

    func stopSound() {
        audioPlayer?.stop()
    }

    var isPlaying: Bool {
        audioPlayer?.isPlaying ?? false
    }
}
