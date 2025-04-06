import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'simple_audio_streamer_platform_interface.dart';

/// An implementation of [SimpleAudioStreamerPlatform] that uses method channels.
class MethodChannelSimpleAudioStreamer extends SimpleAudioStreamerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('simple_audio_streamer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
