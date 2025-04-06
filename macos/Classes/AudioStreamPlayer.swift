import AVFoundation

class AudioStreamPlayer {
  private var engine = AVAudioEngine()
  private var playerNode = AVAudioPlayerNode()
  private var format: AVAudioFormat?

  init() {
    format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 2)
    engine.attach(playerNode)
    engine.connect(playerNode, to: engine.mainMixerNode, format: format)
  }

  func start() {
    do {
      try engine.start()
      playerNode.play()
    } catch {
      print("Audio engine start failed: \(error)")
    }
  }

  func stop() {
    playerNode.stop()
    engine.stop()
  }

  func pushBytes(_ data: Data) {
    guard let format = format else { return }

    let frameLength = UInt32(data.count) / format.streamDescription.pointee.mBytesPerFrame

    data.withUnsafeBytes { rawBuffer in
      let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameLength)!
      buffer.frameLength = frameLength

      let audioPtr = buffer.floatChannelData![0]
      let int16Ptr = rawBuffer.bindMemory(to: Int16.self)

      for i in 0..<Int(frameLength) {
        audioPtr[i] = Float(int16Ptr[i]) / Float(Int16.max)
      }

      playerNode.scheduleBuffer(buffer, completionHandler: nil)
    }
  }
}
