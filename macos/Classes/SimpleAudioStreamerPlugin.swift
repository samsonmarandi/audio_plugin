import FlutterMacOS
import Cocoa

public class SimpleAudioStreamerPlugin: NSObject, FlutterPlugin {
  var player: AudioStreamPlayer?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "simple_audio_streamer", binaryMessenger: registrar.messenger)
    let instance = SimpleAudioStreamerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "start":
      if player == nil {
        player = AudioStreamPlayer()
      }
      player?.start()
      result(nil)
    case "stop":
      player?.stop()
      result(nil)
    case "pushBytes":
      guard let data = call.arguments as? FlutterStandardTypedData else {
        result(FlutterError(code: "INVALID", message: "Invalid data", details: nil))
        return
      }
      player?.pushBytes(data.data)
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
