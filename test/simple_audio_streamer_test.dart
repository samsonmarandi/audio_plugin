import 'package:flutter_test/flutter_test.dart';
import 'package:simple_audio_streamer/simple_audio_streamer.dart';
import 'package:simple_audio_streamer/simple_audio_streamer_platform_interface.dart';
import 'package:simple_audio_streamer/simple_audio_streamer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSimpleAudioStreamerPlatform
    with MockPlatformInterfaceMixin
    implements SimpleAudioStreamerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SimpleAudioStreamerPlatform initialPlatform = SimpleAudioStreamerPlatform.instance;

  test('$MethodChannelSimpleAudioStreamer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSimpleAudioStreamer>());
  });

  test('getPlatformVersion', () async {
    SimpleAudioStreamer simpleAudioStreamerPlugin = SimpleAudioStreamer();
    MockSimpleAudioStreamerPlatform fakePlatform = MockSimpleAudioStreamerPlatform();
    SimpleAudioStreamerPlatform.instance = fakePlatform;

    expect(await simpleAudioStreamerPlugin.getPlatformVersion(), '42');
  });
}
