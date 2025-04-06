import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:simple_audio_streamer/simple_audio_streamer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isPlaying = false;
  Timer? _timer;
  double _phase = 0.0;

  final int sampleRate = 44100;
  final int frequency = 440; // A4
  final int chunkSize = 2048;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSineWave() async {
    if (_isPlaying) return;

    await SimpleAudioStreamer.start();

    _timer = Timer.periodic(const Duration(milliseconds: 20), (_) async {
      final samples = _generateSineWaveChunk();
      await SimpleAudioStreamer.pushBytes(samples);
    });

    setState(() => _isPlaying = true);
  }

  void _stop() async {
    _timer?.cancel();
    await SimpleAudioStreamer.stop();
    setState(() => _isPlaying = false);
  }

  Uint8List _generateSineWaveChunk() {
    final int16Max = 32767;
    final buffer = Int16List(chunkSize * 2); // stereo

    for (int i = 0; i < chunkSize; i++) {
      double time = _phase + i / sampleRate;
      double sample = sin(2 * pi * frequency * time);
      int intSample = (sample * int16Max * 0.2).toInt();

      // Write to left and right channels
      buffer[i * 2] = intSample; // Left
      buffer[i * 2 + 1] = intSample; // Right
    }

    _phase += chunkSize / sampleRate;
    return Uint8List.view(buffer.buffer);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Real-time Sine Generator')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startSineWave,
                child: const Text('Start Sine Wave'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _stop, child: const Text('Stop')),
            ],
          ),
        ),
      ),
    );
  }
}
