import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'simple_audio_streamer_method_channel.dart';

abstract class SimpleAudioStreamerPlatform extends PlatformInterface {
  /// Constructs a SimpleAudioStreamerPlatform.
  SimpleAudioStreamerPlatform() : super(token: _token);

  static final Object _token = Object();

  static SimpleAudioStreamerPlatform _instance = MethodChannelSimpleAudioStreamer();

  /// The default instance of [SimpleAudioStreamerPlatform] to use.
  ///
  /// Defaults to [MethodChannelSimpleAudioStreamer].
  static SimpleAudioStreamerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SimpleAudioStreamerPlatform] when
  /// they register themselves.
  static set instance(SimpleAudioStreamerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
