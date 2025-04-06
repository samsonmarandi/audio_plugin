import 'dart:typed_data';
import 'package:flutter/services.dart';

class SimpleAudioStreamer {
  static const MethodChannel _channel = MethodChannel('simple_audio_streamer');

  static Future<void> start() async {
    await _channel.invokeMethod('start');
  }

  static Future<void> stop() async {
    await _channel.invokeMethod('stop');
  }

  static Future<void> pushBytes(Uint8List data) async {
    await _channel.invokeMethod('pushBytes', data);
  }
}
