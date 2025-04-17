// audio_handler.dart
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  AudioPlayer player = AudioPlayer();

  MyAudioHandler() {
    // Set initial state, you can customize this
    playbackState.add(PlaybackState(
      controls: [MediaControl.play, MediaControl.pause],
      processingState: AudioProcessingState.ready,
    ));
  }

  Future<void> load(String url) async {
    await player.setUrl(url);
  }

  @override
  Future<void> customAction(String name,
      [Map<String, dynamic>? arguments]) async {
    if (name == 'load' && arguments != null && arguments.containsKey('url')) {
      final url = arguments['url'] as String;
      await player.setUrl(url);
    }
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> stop() => player.stop();
}
